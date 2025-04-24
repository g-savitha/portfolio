---
title: "Implementing RBAC and ABAC in Node.js ☕️"
url: "/posts/rbac"
date: 2025-04-09T18:39:17+05:30
draft: false
hideToc: false
enableToc: true
pinned: false
enableTocContent: true
tags:
 - node
 - react
 - authz 
categories:
  - fullstack
  - frontend
  - backend
  - authorization
---


Authorization is a critical aspect of any application that handles sensitive data or operations. In this guide, Let's go through implementing two powerful authorization strategies: Role-Based Access Control (RBAC) and Attribute-Based Access Control (ABAC) in a Node.js application using Express.

## Coffee Shop Management System: The Background 

I built this coffee shop management application primarily to understand and implement different authorization models in a real-world scenario. 

The system features various staff roles with different responsibilities:

- **Owners** who need full access to everything ✨
- **Store Managers** who manage products and prices 💰
- **Shift Managers** who handle day-to-day operations 📋
- **Baristas** who need limited access to mark products as available/unavailable ☕

This diverse permission structure created the perfect playground for exploring both RBAC and ABAC authorization models in depth.

## Tech Stack Overview 

For this project, I used:

- **Database**: PostgreSQL 
- **Backend**: Node.js with Express.js 
- **Frontend**: React with React Bootstrap for UI components 
- **State Management**: React's Context API with local state management
- **Authentication**: JWT (JSON Web Tokens) 

Let me share how I approached the authorization implementation, with code examples you can adapt to your own projects.

## Understanding RBAC vs ABAC 

Before diving into code, let's clarify the difference between these two authorization models:

- **Role-Based Access Control (RBAC)** 👤: Think of this like colored badges at a workplace. If you have a blue badge (role), you can enter certain rooms. If you have a gold badge, you can enter more rooms. It's straightforward to implement but can become limiting for complex authorization requirements.

- **Attribute-Based Access Control (ABAC)** 🧩: This is like a smart security system that considers multiple factors: who you are, what you're trying to access, how you're trying to access it, and the current circumstances. More flexible but more complex to implement.

My coffee shop application uses both:
- RBAC for simple permissions: managing products, setting prices, etc. 
- ABAC for more complex scenarios: who can modify specialty items, when staff can make changes based on their shift, etc. 

## Backend Implementation

### 1. Set Up Authentication

First, let's handle authentication to identify users. I'm using JWT tokens:

```javascript
// src/middleware/auth.js
const jwt = require('jsonwebtoken');
const { Staff } = require('../models');

const authenticate = async (req, res, next) => {
  try {
    // get token from header
    const token = req.header('Authorize')?.replace('Bearer ', '');

    if (!token) {
      return res.status(401).json({ message: 'Authentication required' });
    }

    // verify the token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // find staff member
    const staff = await Staff.findByPk(decoded.id);

    if (!staff) {
      return res.status(401).json({ message: 'Invalid authentication' });
    }
    // add staff to req object
    req.staff = staff;
    next();
  }
  catch (error) {
    res.status(401).json({ message: 'Authentication failed', error: error.message })
  }
}

module.exports = { authenticate };
```

### 2. Implement RBAC

RBAC is implemented as middleware that checks if the authenticated user's role has the required permission:

```javascript
// src/middleware/rbac.js
const roleHirearchy = {
  'owner': ['manage_staff', 'manage_products', 'manage_prices', 'update_availability', 'update_products'],
  'store_manager': ['manage_products', 'manage_prices', 'update_availability', 'update_products'],
  'shift_manager': ['update_products', 'update_availability'],
  'barista': ['update_availability']
};

const checkRole = (requiredPermission) => {
  return (req, res, next) => {
    const staffRole = req.staff.role;

    // Owner has all permissions
    if (staffRole === 'owner') {
      return next();
    }

    const permissions = roleHirearchy[staffRole] || [];

    if (permissions.includes(requiredPermission)) {
      next();
    }
    else {
      res.status(403).json({
        message: `Access denied. Your role (${staffRole}) doesn't have permission: ${requiredPermission}`
      })
    }
  }
}
```

This approach maps roles to permissions and checks if a user's role has the permission required for a particular route.

### 3. Implement ABAC

#### ABAC Explained!

Before diving into the code, let me explain ABAC in simple terms:

Think of ABAC as a smart security guard 👮‍♀️ who makes decisions based on multiple factors:

1. **WHO** you are (user attributes) - your role, training level, which store you work at
2. **WHAT** you're trying to access (resource attributes) - is it a specialty coffee? limited time offer?
3. **HOW** you're trying to access it (action attributes) - are you viewing, editing, or deleting?
4. **WHEN/WHERE** you're doing it (environment attributes) - what time is it? is it a weekend?

Unlike RBAC, which simply checks "Are you a manager? Yes/No", ABAC can handle complex rules like:
- "Baristas with Level 3+ training can modify specialty drinks, but only during their assigned shift"
- "Anyone can modify products they created, unless it's a limited-time offer and they're not working"

Now, let's see how to implement this flexible system:

```javascript
// src/middleware/abac.js
const checkAttributes = (policyFunction) => {
  return async (req, res, next) => {
    try {
      // 1. WHO: Get attributes about the staff member 👩🏻‍🍳
      const staffAttributes = {
        role: req.staff.role,
        shift: req.staff.shift,
        trainingLevel: req.staff.trainingLevel,
        hireDate: req.staff.hireDate,
        storeLocation: req.staff.storeLocation,
        id: req.staff.id
      }

      // 2. WHAT: Get attributes about the resource being accessed ☕️
      let resourceAttributes = {};
      if (req.params.id) {
        // If we're dealing with a product
        if (req.baseUrl.includes('/products')) {
          const product = await Product.findByPk(req.params.id);
          if (product) {
            resourceAttributes = {
              category: product.category,
              specialtyItem: product.specialtyItem,
              limitedTimeOffer: product.limitedTimeOffer,
              createdBy: product.createdBy
            };
          }
        }
      }
      
      // 3. HOW: Get attributes about the action being performed 🛠️
      const actionAttributes = {
        method: req.method, // GET, POST, PUT, DELETE
        time: new Date(),
        path: req.path
      }

      // 4. WHEN/WHERE: Get attributes about the environment 🏙️
      const envAttributes = {
        currentHour: new Date().getHours(),
        isWeekend: [0, 6].includes(new Date().getDay()) // 0 is Sunday, 6 is Saturday
      };
      
      // Run all these attributes through our policy function to decide
      const allowed = policyFunction(
        staffAttributes,
        resourceAttributes,
        actionAttributes,
        envAttributes
      );

      if (allowed) {
        next(); // Allow the request to proceed 
      } else {
        res.status(403).json({
          message: 'Access denied based on attribute policies'
        }); // Block the request
      }
    }
    catch (error) {
      res.status(500).json({ message: 'Error checking attributes', error: error.message });
    }
  }
}
```

#### 4. Define ABAC Policies

With the framework in place, we can define specific policy functions that implement our business rules:

```javascript
// Example policy functions in abac.js - these are the actual rules! 📜

// Rule 1: You can modify something if you created it OR you're a manager
const isCreatorOrManager = (staff, resource) => {
  return staff.id === resource.createdBy ||  //  Did you create it?
    ['owner', 'store_manager'].includes(staff.role);  // Are you a manager?
};

// Rule 2: You need proper training to modify specialty items
const hasTrainingForSpecialtyItems = (staff, resource) => {
  if (!resource.specialtyItem) return true;  // Not a specialty item? Anyone can modify
  return staff.trainingLevel >= 3;  //  Need Level 3+ training for specialty items
};

// Rule 3: You can only modify things during your assigned shift
const canModifyDuringShift = (staff, resource, action, env) => {
  // Define shift hours
  const hour = env.currentHour;

  //  Check if current time is during your shift
  if (staff.shift === 'morning' && (hour >= 6 && hour < 12)) return true;
  if (staff.shift === 'afternoon' && (hour >= 12 && hour < 18)) return true;
  if (staff.shift === 'evening' && (hour >= 18 || hour < 6)) return true;

  //  Managers can work whenever they want
  return ['owner', 'store_manager'].includes(staff.role);
};
```

### 5. Apply Authorization to Routes

Now we can apply our authorization middleware to routes:

```javascript
// Using RBAC
router.get('/', authenticate, async (req, res) => {
  // All authenticated users can access this route
});

router.post('/', authenticate, checkRole('manage_products'), async (req, res) => {
  // Only users with the 'manage_products' permission can access this route
});

// Using ABAC
router.put('/:id', authenticate, checkAttributes((staff, resource, action, env) => {
  // combine multiple policies
  const hasPermissionByRole = ['owner', 'store_manager', 'shift_manager'].includes(staff.role);
  const hasTrainingRequired = policies.hasTrainingForSpecialtyItems(staff, resource);
  const isWorkingShift = policies.canModifyDuringShift(staff, resource, action, env);

  const isCreator = staff.id === resource.createdBy;

  // For specialty items: need higher role OR training + creator status
  if (resource.specialtyItem) {
    return (staff.role === 'owner' || staff.role === 'store_manager') || 
           (hasTrainingRequired && isCreator && isWorkingShift);
  }

  // for limited time offers need to be a creator or manager
  if (resource.limitedTimeOffer) {
    return policies.isCreatorOrManager(staff, resource) && isWorkingShift;
  }

  // Regular products: need appropriate role and be on shift
  return hasPermissionByRole && isWorkingShift;
}), async (req, res) => {
  // Complex authorization logic based on multiple attributes
});
```

Notice how we're applying the middleware in the route definitions. The RBAC middleware is simpler, just checking a single permission, while the ABAC middleware allows for complex decision logic.

### Putting It All Together 

Let's see how ABAC looks in an actual route handling product updates:

```javascript
router.put('/:id', authenticate, checkAttributes((staff, resource, action, env) => {
  // Combine multiple policies to make a complex decision 🧩
  const hasPermissionByRole = ['owner', 'store_manager', 'shift_manager'].includes(staff.role);
  const hasTrainingRequired = policies.hasTrainingForSpecialtyItems(staff, resource);
  const isWorkingShift = policies.canModifyDuringShift(staff, resource, action, env);
  const isCreator = staff.id === resource.createdBy;

  // Special rule for specialty items ✨
  if (resource.specialtyItem) {
    return (staff.role === 'owner' || staff.role === 'store_manager') || 
           (hasTrainingRequired && isCreator && isWorkingShift);
  }

  // Special rule for limited time offers ⏱️
  if (resource.limitedTimeOffer) {
    return policies.isCreatorOrManager(staff, resource) && isWorkingShift;
  }

  // Regular products: need right role and be on shift ☕
  return hasPermissionByRole && isWorkingShift;
}), async (req, res) => {
  // Handle actual product update...
});
```

This single route handles complex authorization logic that would be nearly impossible with simple RBAC!

## Frontend Implementation

On the frontend, we need to:
1. Store user information securely
2. Create protected routes based on roles
3. Show/hide UI elements based on permissions

### 1. Handle Authentication State 

For the frontend authentication state, we need to handle user sessions securely. Here's an approach using React Context for in-memory storage:

```jsx
// src/contexts/AuthContext.jsx
import React, { createContext, useState, useContext, useEffect } from 'react';
import api from '../utils/api';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  // Store user data in memory
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  // Check for existing token on app load
  useEffect(() => {
    const token = localStorage.getItem('token');
    
    if (token) {
      // Verify token and get user info
      api.get('/api/auth/me')
        .then(response => {
          setUser(response.data);
        })
        .catch(() => {
          // Token invalid - clear it
          localStorage.removeItem('token');
        })
        .finally(() => {
          setLoading(false);
        });
    } else {
      setLoading(false);
    }
  }, []);

  const login = async (username, password) => {
    const response = await api.post('/api/auth/login', { username, password });
    // Store only the token in localStorage
    localStorage.setItem('token', response.data.token);
    // Keep user data in memory only
    setUser(response.data.staff);
    return response.data;
  };

  const logout = () => {
    localStorage.removeItem('token');
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, loading }}>
      {children}
    </AuthContext.Provider>
  );
};

// Custom hook for using auth
export const useAuth = () => useContext(AuthContext);
```

### 2. Create Protected Routes 

In React Router, we can create a ProtectedRoute component that checks both authentication and role-based access:

```jsx
// In App.jsx
const ProtectedRoute = ({ children, allowedRoles = [] }) => {
  // Redirect to login if not authenticated 
  if (!isAuthenticated()) {
    return <Navigate to="/login" />;
  }
  
  // Check for role-based access 
  if (allowedRoles.length > 0) {
    const user = getUser();
    if (!allowedRoles.includes(user.role)) {
      // User doesn't have the required role, redirect to safe page 🚫
      return <Navigate to="/products" />;
    }
  }
  
  // User is authenticated and has permission ✅
  return children;
};

// Using the protected route in your app's routes
<Routes>
  {/* Public route - anyone can access */}
  <Route path="/login" element={<Login />} />
  
  {/* Protected route - only specific roles can access */}
  <Route path="/add-product" element={
    <ProtectedRoute allowedRoles={['owner', 'store_manager']}>
      <ProductForm />
    </ProtectedRoute>
  } />
  
  {/* Another protected route with different roles */}
  <Route path="/edit-product/:productId" element={
    <ProtectedRoute allowedRoles={['owner', 'store_manager', 'shift_manager']}>
      <ProductEdit />
    </ProtectedRoute>
  } />
</Routes>
```

### 3. Conditional UI Rendering 

Within components, we can conditionally render UI elements based on the user's role. This creates a personalized experience where users only see actions they're authorized to perform:

```jsx
const ProductList = () => {
  const user = getUser();
  const [products, setProducts] = useState([]);
  
  // Fetch products and other component logic...
  
  return (
    <div className="container mt-4">
      <h2>☕ Coffee Shop Products</h2>
      
      {/* All users can see the product list  */}
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Name</th>
            <th>Price</th>
            <th>Category</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {products.map(product => (
            <tr key={product.id}>
              <td>{product.name}</td>
              <td>₹{product.price}</td>
              <td>{product.category}</td>
              <td>
                <span className={`badge ${product.availability ? 'bg-success' : 'bg-danger'}`}>
                  {product.availability ? 'Available' : 'Unavailable'}
                </span>
              </td>
              <td>
                {/* All staff can toggle availability */}
                <button 
                  className="btn btn-sm btn-outline-primary me-1" 
                  onClick={() => toggleAvailability(product.id)}
                  title="Toggle Availability">
                  <i className="bi bi-toggle-on"></i>
                </button>
                
                {/* Only managers and shift managers can edit  */}
                {(user.role === 'owner' || user.role === 'store_manager' || user.role === 'shift_manager') && (
                  <button 
                    className="btn btn-sm btn-outline-info me-1" 
                    onClick={() => editProduct(product.id)}
                    title="Edit Product">
                    <i className="bi bi-pencil"></i>
                  </button>
                )}
                
                {/* Only owners and store managers can delete  */}
                {(user.role === 'owner' || user.role === 'store_manager') && (
                  <button 
                    className="btn btn-sm btn-outline-danger" 
                    onClick={() => deleteProduct(product.id)}
                    title="Delete Product">
                    <i className="bi bi-trash"></i>
                  </button>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      
      {/* Only owners and store managers can add products  */}
      {(user.role === 'owner' || user.role === 'store_manager') && (
        <button className="btn btn-primary mt-3" onClick={() => navigate('/add-product')}>
          <i className="bi bi-plus-circle me-1"></i> Add New Product
        </button>
      )}
    </div>
  );
};
```

### 4. Handling ABAC in the Frontend 

For ABAC, we need to be more careful. Since ABAC rules can be complex and depend on server-side data, we should:

1. Design the UI to respect likely restrictions
2. Handle API errors gracefully when permissions are denied
3. Inform users clearly about permission issues

```jsx
// Example of handling ABAC-related errors
const handleUpdate = async () => {
  try {
    await api.put(`/api/products/${productId}`, productData);
    showSuccess("Product updated successfully");
    navigate('/products');
  } catch (error) {
    if (error.response?.status === 403) {
      // This is an authorization error
      setError("You don't have permission to perform this action. " + 
               (error.response.data.message || ''));
    } else {
      setError("An error occurred while updating the product");
    }
  }
};
```

## Conclusion 

Implementing robust authorization in your applications is crucial for security. By combining RBAC and ABAC, you can create a flexible system that handles both simple and complex access control requirements.

Key takeaways:
- Use RBAC for straightforward permissions based on roles 🔑
- Use ABAC when you need more context-aware, fine-grained access control 🔍
- Handle both types of authorization on the backend and respect them in your frontend 🔒
- Design your UI to guide users to actions they're authorized to perform 🧭

The coffee shop management system demonstrates that you can implement both strategies in a cohesive way that provides strong security while maintaining usability. While it adds some complexity to your code, the security benefits are well worth the effort.

Remember, authorization is part of your application's security posture, so always validate permissions on the server side, even if you're also doing checks in the frontend.

## Source Code 

If you'd like to explore the complete implementation, check out the GitHub repositories:

- Backend: [https://github.com/g-savitha/Coffee-Shop](https://github.com/g-savitha/Coffee-Shop)
- Frontend: [https://github.com/g-savitha/coffee-shop-ui](https://github.com/g-savitha/coffee-shop-ui)


---

*Hope this was not convoluted and crazy, until next time. Happy coding 💻 🎉*