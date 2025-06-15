<?php
session_start();

// Koneksi ke database
$db_host = "localhost";
$db_user = "root";
$db_password = "";
$db_name = "blog_dinamis";

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

// Cek koneksi
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query untuk mengambil artikel yang sudah di-publish
$sql = "SELECT a.article_id, a.title, a.excerpt, a.slug, a.featured_image, a.published_at, a.author_id,
               GROUP_CONCAT(DISTINCT c.name) AS categories
        FROM articles a
        LEFT JOIN article_category ac ON a.article_id = ac.article_id
        LEFT JOIN categories c ON ac.category_id = c.category_id
        WHERE a.status = 'published'
        GROUP BY a.article_id
        ORDER BY a.published_at DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuotientNote - Beranda</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <header>
    <div class="container">
        <div class="header-left">
            <h1><a href="index.php">QuotientNote</a></h1>
            <nav class="main-nav">
                <ul>
                    <li><a href="index.php" class="active">Beranda</a></li>
                    <li><a href="add_article.php">Tambah Artikel</a></li>
                    <li><a href="categories.php">Kategori</a></li>
                    <li><a href="about.php">Tentang</a></li>
                </ul>
            </nav>
        </div>

        <div class="header-right">
            <?php if(isset($_SESSION['user_id'])): ?>
                <span class="welcome-message">Selamat datang, <?php echo htmlspecialchars($_SESSION['username']); ?>!</span>
                
                <?php if(isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                    <span class="admin-badge">Admin</span>
                <?php endif; ?>

                <a href="add_article.php" class="btn btn-primary">Tambah Artikel</a>
                <a href="logout.php" class="btn btn-secondary">Logout</a>

                <div class="user-menu">
                    <button class="user-menu-btn">▼</button>
                    
                    <div class="user-menu-content">
                        <div class="user-menu-header">
                            <strong><?php echo htmlspecialchars($_SESSION['username']); ?></strong>
                            <small><?php echo isset($_SESSION['role']) ? ucfirst($_SESSION['role']) : 'User'; ?></small>
                        </div>
                        <a href="profile.php" class="user-menu-link profile-link">Profile</a>
                        <a href="my_articles.php" class="user-menu-link articles-link">Artikel Saya</a>
                        
                        <?php if(isset($_SESSION['role']) && $_SESSION['role'] == 'admin'): ?>
                            <hr class="user-menu-divider">
                            <a href="manage_users.php" class="user-menu-link manage-users-link">Manage Users</a>
                        <?php endif; ?>
                    </div>
                </div>

            <?php else: ?>
                <a href="login.php" class="btn btn-primary">Login</a>
                <a href="register.php" class="btn btn-secondary">Register</a>
            <?php endif; ?>
        </div>
    </div>
</header>

    <main class="container">
        <section class="articles">
            <h2>Artikel Terbaru</h2>
            
            <?php
            if ($result && $result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    $categories = !empty($row["categories"]) ? explode(',', $row["categories"]) : [];
                    $date = new DateTime($row["published_at"]);
                    $formatted_date = $date->format('d F Y');
            ?>
                    <article class="article-card">
                        <?php if($row["featured_image"]): ?>
                        <div class="article-image">
                            <img src="<?php echo htmlspecialchars($row["featured_image"]); ?>" alt="<?php echo htmlspecialchars($row["title"]); ?>">
                        </div>
                        <?php endif; ?>
                        
                        <div class="article-content">
                            <h3><a href="article.php?slug=<?php echo htmlspecialchars($row["slug"]); ?>"><?php echo htmlspecialchars($row["title"]); ?></a></h3>
                            <p class="excerpt"><?php echo htmlspecialchars($row["excerpt"]); ?></p>
                            <small>Dipublikasikan pada <?php echo $formatted_date; ?></small>
                            <br>
                            <a href="article.php?slug=<?php echo htmlspecialchars($row["slug"]); ?>" class="read-more">Baca selengkapnya</a>

                            <?php
                            // Tombol aksi untuk admin atau pemilik artikel
                            if (isset($_SESSION['user_id']) && ( (isset($_SESSION['role']) && $_SESSION['role'] == 'admin') || $_SESSION['user_id'] == $row['author_id']) ) {
                            ?>
                                <div class="article-actions">
                                    <a href="edit_article.php?id=<?php echo $row['article_id']; ?>">Edit</a>
                                    <a href="delete_article.php?id=<?php echo $row['article_id']; ?>" onclick="return confirm('Anda yakin ingin menghapus artikel ini?');" style="color: red;">Delete</a>
                                </div>
                            <?php
                            }
                            ?>
                        </div>
                    </article>
            <?php
                }
            } else {
                echo "<p>Tidak ada artikel.</p>";
            }
            ?>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; <?php echo date("Y"); ?> QuotientNote. Nanda Aulia. </p>
        </div>
    </footer>
</body>
</html>
<?php $conn->close(); ?>