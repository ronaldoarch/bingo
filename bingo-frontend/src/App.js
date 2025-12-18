import React, { useState } from 'react';
import Login from './Login';
import Register from './Register';
import Home from './Home';
import './style.css';

function App() {
  const [currentPage, setCurrentPage] = useState('login'); // 'login', 'register', 'home'
  const [user, setUser] = useState(null);

  const handleLoginSuccess = (userData) => {
    setUser(userData);
    setCurrentPage('home');
  };

  const handleRegisterSuccess = () => {
    setCurrentPage('login');
  };

  const handleLogout = () => {
    setUser(null);
    setCurrentPage('login');
  };

  return (
    <div className="App">
      {currentPage !== 'home' && (
        <header className="App-header">
          <h1>Bingo VIP</h1>
        </header>
      )}
      {currentPage === 'login' && (
        <Login
          onLoginSuccess={handleLoginSuccess}
          onGoToRegister={() => setCurrentPage('register')}
        />
      )}
      {currentPage === 'register' && (
        <Register
          onBackToLogin={() => setCurrentPage('login')}
          onRegisterSuccess={handleRegisterSuccess}
        />
      )}
      {currentPage === 'home' && (
        <Home user={user} onLogout={handleLogout} />
      )}
    </div>
  );
}

export default App;

