<?php
// config.php
$host = 'localhost';
$dbname = 'cinema_db';
$username = 'root';
$password = ''; // для XAMPP/WAMP пароль пустой, для MAMP 'root'

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Ошибка подключения: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Кинотеатр - Управление</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        h1 { color: #2c3e50; }
        .container { max-width: 1200px; margin: auto; background: white; padding: 20px; border-radius: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #3498db; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .nav { margin: 20px 0; }
        .nav button { padding: 10px 15px; margin-right: 10px; cursor: pointer; background: #3498db; color: white; border: none; border-radius: 5px; }
        .nav button:hover { background: #2980b9; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 150px; font-weight: bold; }
        input, select { padding: 5px; width: 250px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
<div class="container">
    <h1>🎬 Система управления кинотеатром</h1>
    
    <?php
    // Обработка покупки билета
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['buy_ticket'])) {
        $session_id = $_POST['session_id'];
        $seat_id = $_POST['seat_id'];
        $customer = htmlspecialchars($_POST['customer_name']);
        
        try {
            // Проверка, что место свободно
            $check = $pdo->prepare("SELECT id_ticket FROM tickets WHERE id_session = ? AND id_seat = ? AND status = 'active'");
            $check->execute([$session_id, $seat_id]);
            if ($check->rowCount() > 0) {
                throw new Exception("Это место уже занято на выбранный сеанс!");
            }
            
            $stmt = $pdo->prepare("INSERT INTO tickets (id_session, id_seat, customer_name, status) VALUES (?, ?, ?, 'active')");
            $stmt->execute([$session_id, $seat_id, $customer]);
            echo "<p class='success'>✅ Билет успешно куплен!</p>";
        } catch (Exception $e) {
            echo "<p class='error'>❌ Ошибка: " . $e->getMessage() . "</p>";
        }
    }
    
    // Возврат билета
    if (isset($_GET['refund']) && is_numeric($_GET['refund'])) {
        $ticket_id = $_GET['refund'];
        try {
            $stmt = $pdo->prepare("UPDATE tickets SET status = 'refunded' WHERE id_ticket = ? AND status = 'active'");
            $stmt->execute([$ticket_id]);
            if ($stmt->rowCount() > 0) {
                echo "<p class='success'>🔄 Билет №$ticket_id возвращён.</p>";
            } else {
                echo "<p class='error'>❌ Билет не найден или уже возвращён.</p>";
            }
        } catch (Exception $e) {
            echo "<p class='error'>Ошибка: " . $e->getMessage() . "</p>";
        }
    }
    ?>
    
    <div class="nav">
        <button onclick="showSection('films')">🎞️ Фильмы</button>
        <button onclick="showSection('sessions')">📅 Сеансы</button>
        <button onclick="showSection('buy')">🎫 Купить билет</button>
        <button onclick="showSection('tickets')">🎟️ Проданные билеты</button>
    </div>
    
    <!-- Фильмы -->
    <div id="films" class="section" style="display:none;">
        <h2>📽️ Список фильмов</h2>
        <table>
            <tr><th>ID</th><th>Название</th><th>Длительность (мин)</th><th>Рейтинг</th><th>Описание</th></tr>
            <?php
            $films = $pdo->query("SELECT * FROM films ORDER BY title");
            foreach ($films as $row) {
                echo "<tr><td>{$row['id_film']}</td><td>{$row['title']}</td><td>{$row['duration_min']}</td><td>{$row['age_rating']}</td><td>{$row['description']}</td></tr>";
            }
            ?>
        </table>
    </div>
    
    <!-- Сеансы -->
    <div id="sessions" class="section" style="display:none;">
        <h2>📆 Расписание сеансов</h2>
        <table>
            <tr><th>ID</th><th>Фильм</th><th>Зал</th><th>Дата и время</th><th>Цена (₽)</th></tr>
            <?php
            $sessions = $pdo->query("
                SELECT s.id_session, f.title, h.hall_name, s.start_time, s.base_price 
                FROM sessions s
                JOIN films f ON s.id_film = f.id_film
                JOIN halls h ON s.id_hall = h.id_hall
                ORDER BY s.start_time
            ");
            foreach ($sessions as $row) {
                echo "<tr><td>{$row['id_session']}</td><td>{$row['title']}</td><td>{$row['hall_name']}</td><td>{$row['start_time']}</td><td>{$row['base_price']}</td></tr>";
            }
            ?>
        </table>
    </div>
    
    <!-- Форма покупки билета -->
    <div id="buy" class="section" style="display:none;">
        <h2>🎫 Оформление билета</h2>
        <form method="post">
            <div class="form-group">
                <label>Выберите сеанс:</label>
                <select name="session_id" required>
                    <option value="">-- Выберите --</option>
                    <?php
                    $sessions = $pdo->query("
                        SELECT s.id_session, f.title, h.hall_name, s.start_time, s.base_price 
                        FROM sessions s
                        JOIN films f ON s.id_film = f.id_film
                        JOIN halls h ON s.id_hall = h.id_hall
                        ORDER BY s.start_time
                    ");
                    foreach ($sessions as $row) {
                        echo "<option value='{$row['id_session']}'>[{$row['id_session']}] {$row['title']} - {$row['hall_name']} - {$row['start_time']} ({$row['base_price']}₽)</option>";
                    }
                    ?>
                </select>
            </div>
            <div class="form-group">
                <label>Место (ID места из таблицы мест):</label>
                <input type="number" name="seat_id" required placeholder="Введите id_mesta">
                <small>Сначала посмотрите доступные места через phpMyAdmin</small>
            </div>
            <div class="form-group">
                <label>Имя зрителя:</label>
                <input type="text" name="customer_name" required>
            </div>
            <button type="submit" name="buy_ticket">Купить билет</button>
        </form>
        <p>💡 <strong>Совет:</strong> Для просмотра свободных мест выполните SQL в phpMyAdmin:
        <code>SELECT * FROM seats WHERE id_seat NOT IN (SELECT id_seat FROM tickets WHERE id_session = ВАШ_СЕАНС AND status='active');</code>
        </p>
    </div>
    
    <!-- Список билетов -->
    <div id="tickets" class="section" style="display:none;">
        <h2>🎟️ Проданные билеты</h2>
        <table>
            <tr><th>ID билета</th><th>Сеанс (фильм, зал, время)</th><th>Место (ряд/место)</th><th>Покупатель</th><th>Статус</th><th>Действие</th></tr>
            <?php
            $tickets = $pdo->query("
                SELECT t.id_ticket, f.title, h.hall_name, s.start_time, se.row_num, se.seat_num, t.customer_name, t.status, t.id_session
                FROM tickets t
                JOIN sessions s ON t.id_session = s.id_session
                JOIN films f ON s.id_film = f.id_film
                JOIN halls h ON s.id_hall = h.id_hall
                JOIN seats se ON t.id_seat = se.id_seat
                ORDER BY t.purchase_time DESC
            ");
            foreach ($tickets as $row) {
                $refund_link = ($row['status'] == 'active') ? "<a href='?refund={$row['id_ticket']}' onclick='return confirm(\"Вернуть билет?\")'>Вернуть</a>" : "Возвращён";
                echo "<tr>
                        <td>{$row['id_ticket']}</td>
                        <td>{$row['title']} / {$row['hall_name']} / {$row['start_time']}</td>
                        <td>Ряд {$row['row_num']}, место {$row['seat_num']}</td>
                        <td>{$row['customer_name']}</td>
                        <td>{$row['status']}</td>
                        <td>$refund_link</td>
                      </tr>";
            }
            ?>
        </table>
    </div>
</div>

<script>
function showSection(sectionId) {
    const sections = ['films', 'sessions', 'buy', 'tickets'];
    sections.forEach(id => {
        document.getElementById(id).style.display = 'none';
    });
    document.getElementById(sectionId).style.display = 'block';
}
// По умолчанию показываем фильмы
showSection('films');
</script>
</body>
</html>