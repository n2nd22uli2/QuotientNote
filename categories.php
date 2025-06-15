<?php
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

// Query untuk daftar kategori dan jumlah artikel yang sudah 'published'
$sql = "SELECT c.category_id, c.name, c.slug, c.description, COUNT(a.article_id) as article_count 
        FROM categories c
        LEFT JOIN article_category ac ON c.category_id = ac.category_id
        LEFT JOIN articles a ON ac.article_id = a.article_id AND a.status = 'published'
        GROUP BY c.category_id
        ORDER BY c.name";

$result = $conn->query($sql);

// Set judul halaman sebelum memanggil header
$page_title = "Daftar Kategori";
include 'templates/header.php';
?>

<main class="container page-layout">
    <div class="main-content">
        <section class="categories-list">
            <h1 class="page-title">Daftar Kategori</h1>
            <div class="categories-grid">
                <?php
                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                ?>
                        <div class="category-card">
                            <div class="card-content">
                                <h2><a href="category.php?slug=<?php echo htmlspecialchars($row["slug"]); ?>"><?php echo htmlspecialchars($row["name"]); ?></a></h2>
                                <?php if($row["description"]): ?>
                                    <p class="description"><?php echo htmlspecialchars($row["description"]); ?></p>
                                <?php endif; ?>
                            </div>
                            <div class="card-footer">
                                <span class="article-count"><?php echo $row["article_count"]; ?> artikel</span>
                            </div>
                        </div>
                <?php
                    }
                } else {
                    echo "<p>Belum ada kategori yang ditambahkan.</p>";
                }
                ?>
            </div>
        </section>
    </div>
    
    <aside class="sidebar">
        <div class="widget">
            <h3>Artikel Terbaru</h3>
            <?php
            // Query untuk artikel terbaru
            $recent_sql = "SELECT title, slug FROM articles WHERE status = 'published' ORDER BY published_at DESC LIMIT 5";
            $recent_result = $conn->query($recent_sql);
            
            if ($recent_result && $recent_result->num_rows > 0) {
                echo "<ul>";
                while($recent_row = $recent_result->fetch_assoc()) {
                    echo "<li><a href='article.php?slug=" . htmlspecialchars($recent_row["slug"]) . "'>" . htmlspecialchars($recent_row["title"]) . "</a></li>";
                }
                echo "</ul>";
            } else {
                echo "<p>Tidak ada artikel terbaru.</p>";
            }
            ?>
        </div>
    </aside>
</main>

<?php
include 'templates/footer.php';
?>