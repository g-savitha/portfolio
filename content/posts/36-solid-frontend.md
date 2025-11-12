---
title: "🎯 SOLID Principles Aren't Just for Backend!"
date: 2025-11-12T19:15:55+05:30
draft: false
hideToc: false
enableToc: true
pinned: false
enableTocContent: true
tags:
  - design-patterns
  - react
  - frontend
categories:
  - frontend
---

Think SOLID principles are only for backend developers? Think again.

These powerful design principles can transform your frontend code too - making it cleaner, more maintainable, and scalable. Let's understand how.

The SOLID principles, originally from object-oriented programming, can be effectively applied to frontend development. Here's how each principle maps to frontend practices:

## S - Single Responsibility Principle (SRP)
A component should have only one responsibility or reason to change. Separate UI rendering from data fetching and state management.

**Example**: Separate UserCard (renders UI) from data fetching logic
```jsx
// ❌ Bad: Component does too much
function UserCard({ userId }) {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(setUser);
  }, [userId]);
  
  return <div>{user?.name}</div>;
}

// ✅ Good: Separate concerns
function useUser(userId) {
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(setUser);
  }, [userId]);
  
  return user;
}

function UserCard({ user }) {
  return (
    <div className="card">
      <img src={user.avatar} alt={user.name} />
      <h3>{user.name}</h3>
      <p>{user.email}</p>
    </div>
  );
}

// Usage
function App() {
  const user = useUser(123);
  return <UserCard user={user} />;
}
```

## O - Open/Closed Principle (OCP)
Components should be open for extension but closed for modification. Add new functionality without changing existing code.

**Example**: Button with variant prop for different styles
```jsx
// ✅ Good: Extend via props, not modification
function Button({ variant = 'primary', children, ...props }) {
  return (
    <button 
      className={`btn btn-${variant}`} 
      {...props}
    >
      {children}
    </button>
  );
}

// Add new variants without touching Button code
function App() {
  return (
    <>
      <Button variant="primary">Save</Button>
      <Button variant="secondary">Cancel</Button>
      <Button variant="danger">Delete</Button>
      <Button variant="success">Confirm</Button>
    </>
  );
}
```

## L - Liskov Substitution Principle (LSP)
Derived components should be substitutable for their base components without affecting correctness.

**Example**: IconButton can replace Button anywhere
```jsx
function Button({ children, onClick, ...props }) {
  return (
    <button onClick={onClick} {...props}>
      {children}
    </button>
  );
}

function IconButton({ icon, children, onClick, ...props }) {
  return (
    <button onClick={onClick} {...props}>
      <Icon name={icon} />
      {children}
    </button>
  );
}

// ✅ Both work interchangeably
function Toolbar() {
  return (
    <div>
      <Button onClick={handleSave}>Save</Button>
      <IconButton icon="trash" onClick={handleDelete}>
        Delete
      </IconButton>
    </div>
  );
}
```

## I - Interface Segregation Principle (ISP)
Components should not depend on props they don't use. Create focused props for specific needs.

**Example**: ListItem with only necessary props
```jsx
// ❌ Bad: Passing entire object with unused data
function ListItem({ item }) {
  // item has: id, name, price, description, category, 
  // stock, reviews, ratings, seller, etc.
  // But we only need name and price!
  return (
    <li>
      {item.name} - ${item.price}
    </li>
  );
}

// ✅ Good: Only pass what's needed
function ListItem({ name, price }) {
  return (
    <li>
      {name} - ${price}
    </li>
  );
}

function ProductList({ products }) {
  return (
    <ul>
      {products.map(product => (
        <ListItem 
          key={product.id}
          name={product.name}
          price={product.price}
        />
      ))}
    </ul>
  );
}
```

## D - Dependency Inversion Principle (DIP)
Components should not depend on low-level modules directly. Use dependency injection for better testability and flexibility.

**Example**: Pass data-fetching function as prop
```jsx
// ❌ Bad: Hard-coded dependency
import api from './api';

function ProductList() {
  const [products, setProducts] = useState([]);
  
  useEffect(() => {
    api.fetchProducts().then(setProducts);
  }, []);
  
  return products.map(p => <Product key={p.id} {...p} />);
}

// ✅ Good: Inject dependency
function ProductList({ fetchProducts }) {
  const [products, setProducts] = useState([]);
  
  useEffect(() => {
    fetchProducts().then(setProducts);
  }, [fetchProducts]);
  
  return products.map(p => <Product key={p.id} {...p} />);
}

// Now easily swap data sources or mock for testing
function App() {
  return (
    <ProductList 
      fetchProducts={() => api.fetchProducts()} 
    />
  );
}

// In tests
function Test() {
  return (
    <ProductList 
      fetchProducts={() => Promise.resolve(mockProducts)} 
    />
  );
}
```

## The Benefits:
✅ Components are easier to test, debug, and reuse
✅ Code is more modular and maintainable
✅ Faster feature development as complexity grows
✅ Better team collaboration with clear boundaries

Applying SOLID principles in frontend development improves the modularity, reusability, testability, and scalability of your codebase—especially as applications grow in complexity.

