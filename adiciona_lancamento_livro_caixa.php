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

// Consulta SQL para buscar os dados da tabela 'sis_contaspagar'
$sqlContasPagar = "SELECT id, nrdocumento FROM sis_contaspagar";
$resultContasPagar = $conn->query($sqlContasPagar);

// Consulta SQL para buscar os dados da tabela 'sis_lanc'
$sqlLanc = "SELECT id, nossonum FROM sis_lanc";
$resultLanc = $conn->query($sqlLanc);

// Verifica se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Recebe os dados do formulário
    $uuid_caixa = $_POST['uuid_caixa'] ?? null;
    $data = $_POST['data'];
    $historico = $_POST['historico'];
    $complemento = $_POST['complemento'] ?? null;
    $usuario = $_POST['usuario'];
    $valor = $_POST['valor'] ?? null;
    $tipo_transacao = $_POST['tipo_transacao'];

    // Define se é entrada ou saída
    $entrada = ($tipo_transacao == 'entrada') ? $valor : null;
    $saida = ($tipo_transacao == 'saida') ? $valor : null;

    // IDs das seleções
    $contas_id = $_POST['contas'];
    $plano_contas_id = $_POST['planodecontas'];
    $contas_pagar_id = $_POST['contaspagar'];
    $lanc_id = $_POST['lanc'];

    // Início da transação
    $conn->begin_transaction();

    try {
        // Insere os dados na tabela sis_caixa
        $stmt = $conn->prepare("INSERT INTO sis_caixa (uuid_caixa, data, historico, complemento, entrada, saida, usuario) 
                               VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssds", $uuid_caixa, $data, $historico, $complemento, $entrada, $saida, $usuario);
        $stmt->execute();

        // Recupera o ID inserido em sis_caixa
        $sis_caixa_id = $stmt->insert_id;

        // Insere os dados na tabela mgt_caixa_aux com o ID recuperado de sis_caixa
        $stmt_aux = $conn->prepare("INSERT INTO mgt_caixa_aux (sis_caixa_id, mgt_contas_id, mgt_planodecontas_id, sis_contaspagar_id, sis_lanc_id) 
                                    VALUES (?, ?, ?, ?, ?)");
        $stmt_aux->bind_param("iiiii", $sis_caixa_id, $contas_id, $plano_contas_id, $contas_pagar_id, $lanc_id);
        $stmt_aux->execute();

        // Confirma a transação
        $conn->commit();
        echo "Dados cadastrados com sucesso!";
    } catch (Exception $e) {
        // Se houver erro, reverte a transação
        $conn->rollback();
        echo "Erro: " . $e->getMessage();
    }
}

?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Formulário de Cadastro - Caixa</title>
</head>
<body>

<h2>Formulário de Cadastro de Caixa</h2>

<section class="formulario">
    <form action="" method="POST">
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
            if ($resultContas->num_rows > 0) {
                while ($row = $resultContas->fetch_assoc()) {
                    echo "<option value=\"" . $row['id'] . "\">" . $row['descricao'] . "</option>";
                }
            }
            ?>
        </select><br><br>

        <!-- Seleção de Plano de Contas (mgt_planodecontas) -->
        <label for="planodecontas">Selecione o Plano de Contas (Descrição):</label>
        <select id="planodecontas" name="planodecontas" required>
            <option value="">Selecione um plano de contas</option>
            <?php
            if ($resultPlanoContas->num_rows > 0) {
                while ($row = $resultPlanoContas->fetch_assoc()) {
                    echo "<option value=\"" . $row['id'] . "\">" . $row['descricao'] . "</option>";
                }
            }
            ?>
        </select><br><br>

        <!-- Seleção de Contas a Pagar (sis_contaspagar) -->
        <label for="contaspagar">Selecione Conta a Pagar (Número de documento para referência):</label>
        <select id="contaspagar" name="contaspagar" required>
            <option value="">Selecione uma conta</option>
            <?php
            if ($resultContasPagar->num_rows > 0) {
                while ($row = $resultContasPagar->fetch_assoc()) {
                    echo "<option value=\"" . $row['id'] . "\">" . $row['nrdocumento'] . "</option>";
                }
            }
            ?>
        </select><br><br>

        <!-- Seleção de Lançamento (sis_lanc) -->
        <label for="lanc">Selecione o Lançamento (Número do documento ou identificação associada):</label>
        <select id="lanc" name="lanc" required>
            <option value="">Selecione um lançamento</option>
            <?php
            if ($resultLanc->num_rows > 0) {
                while ($row = $resultLanc->fetch_assoc()) {
                    echo "<option value=\"" . $row['id'] . "\">" . $row['nossonum'] . "</option>";
                }
            }
            ?>
        </select><br><br>

        <label for="valor">Valor (R$):</label>
        <input type="number" id="valor" name="valor" step="0.01" required><br><br>

        <label for="usuario">Usuário (ID):</label>
        <input type="number" id="usuario" name="usuario" required><br><br>

        <input type="submit" value="Cadastrar">
    </form>
</section>

</body>
</html>