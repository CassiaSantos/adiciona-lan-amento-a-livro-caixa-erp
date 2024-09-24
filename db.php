<?php
// ARQUIVO DE CONEXÃO COM BANCO DE DADOS:

$servername = "localhost"; // Define o nome do servidor de banco de dados, geralmente "localhost".
$username = "root"; // Nome de usuário para acessar o banco de dados.
$password = ""; // Senha para acessar o banco de dados.
$dbname = "erpl"; // Nome do banco de dados que você deseja acessar.

// Cria uma conexão com o banco de dados usando as credenciais fornecidas.
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica se a conexão foi bem-sucedida.
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error); // Se houver erro, a execução para e uma mensagem é exibida.
}

// Recupera os dados da tabela mgt_planodecontas
$sql = "SELECT id, descricao FROM mgt_planodecontas WHERE pai IS NOT NULL"; // Somente contas com pai (subcontas)
$result = $conn->query($sql);

?>