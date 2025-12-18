import React, { useState } from 'react';

function Login() {
  const [loginInfo, setLoginInfo] = useState({
    username: '',
    password: '',
  });

  const handleChange = (e) => {
    setLoginInfo({
      ...loginInfo,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      // Usar variável de ambiente ou URL padrão
      const apiUrl = process.env.REACT_APP_API_URL || 'http://localhost:8080';
      
      const response = await fetch(`${apiUrl}/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: loginInfo.username,
          password: loginInfo.password,
        }),
      });

      const data = await response.json();

      if (data.success) {
        // Redirecionar para página principal ou home
        alert('Login bem-sucedido!');
        // Aqui você pode redirecionar: window.location.href = '/home';
      } else {
        alert(data.message || 'Credenciais inválidas!');
      }
    } catch (error) {
      console.error('Erro ao fazer login:', error);
      alert('Erro ao conectar com o servidor. Tente novamente.');
    }
  };

  return (
    <div className="login-container">
      <h2>Entrar</h2>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="username"
          placeholder="CPF/Telefone/E-mail ou Login"
          value={loginInfo.username}
          onChange={handleChange}
          required
        />
        <input
          type="password"
          name="password"
          placeholder="Digite sua senha"
          value={loginInfo.password}
          onChange={handleChange}
          required
        />
        <div className="buttons">
          <button type="submit" className="btn-green">
            Entrar
          </button>
          <button type="button" className="btn-purple">
            Registre-se Já!
          </button>
        </div>
      </form>
    </div>
  );
}

export default Login;

