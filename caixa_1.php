<?php
include 'db.php'; // Inclui o arquivo de conexão com o banco de dados

// Verifica se a conexão com o banco de dados foi bem-sucedida
if (!$conn) {
    die("Erro na conexão: " . mysqli_connect_error());
}

// Consulta SQL para buscar os dados da tabela 'mgt_contas'
$sqlContas = "SELECT id, descricao FROM mgt_contas";
$resultContas = $conn->query($sqlContas);

// Consulta SQL para buscar os dados da tabela 'mgt_planodecontas'
$sqlPlanoContas = "SELECT id, descricao FROM mgt_planodecontas";
$resultPlanoContas = $conn->query($sqlPlanoContas);
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulário de Cadastro - Caixa</title>
</head>
<body>

<h2>Formulário de Cadastro de Caixa</h2>
<form action="processa_saida.php" method="POST">
    <label for="uuid_caixa">UUID Caixa:</label>
    <input type="text" id="uuid_caixa" name="uuid_caixa"><br><br>

    <label for="data">Data:</label>
    <input type="datetime-local" id="data" name="data" required><br><br>

    <label for="historico">Histórico:</label>
    <input type="text" id="historico" name="historico" required><br><br>

    <label for="complemento">Complemento:</label>
    <textarea id="complemento" name="complemento"></textarea><br><br>

    <label>Tipo de Transação:</label><br>
    <input type="radio" id="entrada" name="tipo_transacao" value="entrada" required>
    <label for="entrada">Entrada (R$)</label><br>

    <input type="radio" id="saida" name="tipo_transacao" value="saida" required>
    <label for="saida">Saída (R$)</label><br><br>

    <!-- Seleção de Contas (mgt_contas) -->
    <label for="contas">Selecione a Conta:</label>
    <select id="contas" name="contas" required>
        <option value="">Selecione uma conta</option>
        <?php
        // Verifica se há resultados na tabela 'mgt_contas'
        if ($resultContas->num_rows > 0) {
            // Preenche o select com as opções
            while ($row = $resultContas->fetch_assoc()) {
                echo "<option value=\"" . $row['id'] . "\">" . $row['descricao'] . "</option>";
            }
        } else {
            echo "<option value=\"\">Nenhuma conta encontrada</option>";
        }
        ?>
    </select><br><br>

    <!-- Seleção de Plano de Contas (mgt_planodecontas) -->
    <label for="planodecontas">Selecione o Plano de Contas:</label>
    <select id="planodecontas" name="planodecontas" required>
        <option value="">Selecione um plano de contas</option>
        <?php
        // Verifica se há resultados na tabela 'mgt_planodecontas'
        if ($resultPlanoContas->num_rows > 0) {
            // Preenche o select com as opções
            while ($row = $resultPlanoContas->fetch_assoc()) {
                echo "<option value=\"" . $row['id'] . "\">" . $row['descricao'] . "</option>";
            }
        } else {
            echo "<option value=\"\">Nenhum plano de contas encontrado</option>";
        }
        ?>
    </select><br><br>

    <label for="valor">Valor (R$):</label>
    <input type="number" id="valor" name="valor" step="0.01" required><br><br>

    <label for="usuario">Usuário (ID):</label>
    <input type="number" id="usuario" name="usuario" required><br><br>

    <input type="submit" value="Cadastrar">
</form>

</body>

<?php
// Fechar a conexão com o banco de dados
$conn->close();
?>

</html>