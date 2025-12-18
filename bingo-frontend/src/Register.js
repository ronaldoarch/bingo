import React, { useState } from 'react';

function Register({ onBackToLogin, onRegisterSuccess }) {
  const [registerInfo, setRegisterInfo] = useState({
    username: '',
    password: '',
    confirmPassword: '',
  });
  const [error, setError] = useState('');

  const handleChange = (e) => {
    setRegisterInfo({
      ...registerInfo,
      [e.target.name]: e.target.value,
    });
    setError(''); // Limpar erro ao digitar
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    // Validações
    if (!registerInfo.username || !registerInfo.password || !registerInfo.confirmPassword) {
      setError('Todos os campos são obrigatórios');
      return;
    }

    if (registerInfo.password !== registerInfo.confirmPassword) {
      setError('As senhas não coincidem');
      return;
    }

    if (registerInfo.password.length < 6) {
      setError('A senha deve ter pelo menos 6 caracteres');
      return;
    }

    try {
      const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:8080';

      const response = await fetch(`${apiUrl}/register`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: registerInfo.username,
          password: registerInfo.password,
        }),
      });

      const data = await response.json();

      if (data.success) {
        alert('Cadastro realizado com sucesso! Faça login para continuar.');
        if (onRegisterSuccess) {
          onRegisterSuccess();
        } else {
          onBackToLogin();
        }
      } else {
        setError(data.message || 'Erro ao realizar cadastro');
      }
    } catch (error) {
      console.error('Erro ao fazer cadastro:', error);
      setError('Erro ao conectar com o servidor. Tente novamente.');
    }
  };

  return (
    <div className="login-container">
      <h2>Cadastro</h2>
      <form onSubmit={handleSubmit}>
        {error && <div className="error-message">{error}</div>}
        <input
          type="text"
          name="username"
          placeholder="CPF/Telefone/E-mail ou Login"
          value={registerInfo.username}
          onChange={handleChange}
          required
        />
        <input
          type="password"
          name="password"
          placeholder="Digite sua senha"
          value={registerInfo.password}
          onChange={handleChange}
          required
        />
        <input
          type="password"
          name="confirmPassword"
          placeholder="Confirme sua senha"
          value={registerInfo.confirmPassword}
          onChange={handleChange}
          required
        />
        <div className="buttons">
          <button type="submit" className="btn-green">
            Cadastrar
          </button>
          <button type="button" className="btn-purple" onClick={onBackToLogin}>
            Voltar para Login
          </button>
        </div>
      </form>
    </div>
  );
}

export default Register;

