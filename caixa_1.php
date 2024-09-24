<?php
include 'db.php'; // Inclui o arquivo de conexão com o banco de dados.

// Verifica se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    try {
        // Cria a conexão com o banco de dados usando PDO
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        

        // Recebe os dados do formulário
        $uuid_caixa = $_POST['uuid_caixa'] ?? null;
        $data = $_POST['data'];
        $historico = $_POST['historico'];
        $complemento = $_POST['complemento'] ?? null;
        $usuario = $_POST['usuario'];
        
        // Recebe a entrada ou saída de acordo com a seleção do rádio
        $valor = $_POST['valor'] ?? null;
        $tipo_transacao = $_POST['tipo_transacao']; // Define se é 'entrada' ou 'saida'

        // Define valores de entrada ou saída com base na seleção
        $entrada = ($tipo_transacao == 'entrada') ? $valor : null;
        $saida = ($tipo_transacao == 'saida') ? $valor : null;

        // Prepara a query SQL para inserção
        $stmt = $pdo->prepare("INSERT INTO sis_caixa (uuid_caixa, data, historico, complemento, entrada, saida, usuario) 
                               VALUES (:uuid_caixa, :data, :historico, :complemento, :entrada, :saida, :usuario)");

        // Vincula os valores aos parâmetros
        $stmt->bindParam(':uuid_caixa', $uuid_caixa);
        $stmt->bindParam(':data', $data);
        $stmt->bindParam(':historico', $historico);
        $stmt->bindParam(':complemento', $complemento);
        $stmt->bindParam(':entrada', $entrada);
        $stmt->bindParam(':saida', $saida);
        $stmt->bindParam(':usuario', $usuario);

        // Executa a query
        if ($stmt->execute()) {
            echo "Dados inseridos com sucesso!";
        } else {
            echo "Erro ao inserir os dados.";
        }
    } catch (PDOException $e) {
        echo "Erro: " . $e->getMessage();
    }
}
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

    <!-- Seleção de Plano de Contas -->
    <label for="planodecontas">Selecione o Plano de Contas:</label>
        <select id="planodecontas" name="planodecontas" required>
            <option value="">Selecione uma conta</option>
            <?php
            // Preenche as opções do select com os dados do plano de contas
            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<option value=\"" . $row['id'] . "\">" . $row['descricao'] . "</option>";
                }
            } else {
                echo "<option value=\"\">Nenhuma conta encontrada</option>";
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
</html>