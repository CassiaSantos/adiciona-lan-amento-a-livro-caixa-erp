<?php
include 'db.php'; // Inclui o arquivo de conexão com o banco de dados.

// Verifica se o formulário foi submetido
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $historico = $_POST['historico'];
    $complemento = $_POST['complemento'];
    $planodecontas_id = $_POST['planodecontas'];
    $tipo = $_POST['tipo'];
    $valor = $_POST['valor'];

    // Define se é entrada ou saída
    $entrada = ($tipo === 'entrada') ? $valor : 0;
    $saida = ($tipo === 'saida') ? $valor : 0;

    // Insere os dados no banco
    $sql = "INSERT INTO sis_caixa (uuid_caixa, data, historico, complemento, entrada, saida, usuario) 
            VALUES (UUID(), NOW(), ?, ?, ?, ?, 1)"; // O usuário com id 1 é apenas um exemplo

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssdd", $historico, $complemento, $entrada, $saida);

    if ($stmt->execute()) {
        echo "Saída cadastrada com sucesso!";
    } else {
        echo "Erro ao cadastrar saída: " . $conn->error;
    }

    $stmt->close();
}

$conn->close();
?>