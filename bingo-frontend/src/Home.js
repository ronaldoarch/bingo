import React from 'react';

function Home({ user, onLogout }) {
  return (
    <div className="home-container">
      <header className="home-header">
        <h1>Bingo VIP</h1>
        <div className="user-info">
          <span>Bem-vindo, <strong>{user?.username || 'Usuário'}</strong>!</span>
          <button onClick={onLogout} className="btn-logout">
            Sair
          </button>
        </div>
      </header>
      <main className="home-content">
        <div className="welcome-card">
          <h2>Bem-vindo ao Bingo VIP!</h2>
          <p>Você está logado com sucesso.</p>
          <p>Seu ID de usuário: <strong>{user?.id}</strong></p>
        </div>
        <div className="features">
          <h3>Funcionalidades em breve:</h3>
          <ul>
            <li>🎲 Jogar Bingo</li>
            <li>🎰 Salas de Jogo</li>
            <li>🏆 Ranking</li>
            <li>💰 Histórico de Prêmios</li>
          </ul>
        </div>
      </main>
    </div>
  );
}

export default Home;

