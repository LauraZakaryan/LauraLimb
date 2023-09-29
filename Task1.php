<?php
session_start();

if (!isset($_SESSION['user_data'])) {
    $_SESSION['user_data'] = [];
}

$data = [];

if (isset($_POST['submit']) && isset($_POST['fname']) && isset($_POST['lname']) && isset($_POST['birthdate'])
    && isset($_POST['age']) && isset($_POST['aboutme']) && isset($_FILES['image'])) {
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $birthdate = $_POST['birthdate'];
    $age = $_POST['age'];
    $aboutme = $_POST['aboutme'];

    if ($_FILES['image']['error'] === UPLOAD_ERR_OK) {
        $imageFileName = $_FILES['image']['name'];
        $imageTmpName = $_FILES['image']['tmp_name'];
        $imagePath = 'images/' . $imageFileName;

        move_uploaded_file($imageTmpName, $imagePath);
    } else {
        echo "Error uploading image.";
    }

    $namePattern = '/^[A-Za-z\s]+$/';

    if (preg_match($namePattern, $fname) && preg_match($namePattern, $lname)) {
        $entry = [
            'fname' => $fname,
            'lname' => $lname,
            'birthdate' => $birthdate,
            'age' => $age,
            'aboutme' => $aboutme,
            'image' => $imagePath,
        ];

        $data[] = $entry;

        $_SESSION['user_data'][] = $entry;
    } else {
        echo "Invalid first name or last name. Only alphabetic characters and spaces are allowed.";
    }
}

// Pagination configuration
$itemsPerPage = 3;
$totalEntries = count($_SESSION['user_data']);
$totalPages = ceil($totalEntries / $itemsPerPage);
$currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

$startIndex = ($currentPage - 1) * $itemsPerPage;
$endIndex = min($startIndex + $itemsPerPage, $totalEntries);
?>

<html>
<style>
    table, th, td {
        border: 1px solid black;
    }
</style>
<body>
<?php
function drawForm()
{
    echo '
    <h1>Registration</h1> 
    
    <form action="" method="post" enctype="multipart/form-data">
    First name: <input type="text" name="fname"><br><br>
    Last name: <input type="text" name="lname"><br><br>
    Date of birth: <input type="date" id="birthdate" name="birthdate"><br><br>
    Age: <input type="number" id="age" name="age" min="1" max="1000"><br><br>
    About me: <textarea name="aboutme" rows="5" cols="40"></textarea><br><br>
    Image: <input type="file" name="image"><br><br>
    <input type="submit" name="submit" value="submit"></form>';
}

drawForm()
?>

<h2>Data</h2>
<table style="width:100%">
    <tr>
        <th>User</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Date of Birth</th>
        <th>Age</th>
        <th>About Me</th>
        <th>Image</th>
        <th>Edit</th>
    </tr>
    <?php
    for ($i = $startIndex; $i < $endIndex; $i++) {
        $entry = $_SESSION['user_data'][$i];
        echo '<tr>';
        echo '<td>' . ($i + 1) . '</td>';
        echo '<td>' . $entry['fname'] . '</td>';
        echo '<td>' . $entry['lname'] . '</td>';
        echo '<td>' . $entry['birthdate'] . '</td>';
        echo '<td>' . $entry['age'] . '</td>';
        echo '<td>' . $entry['aboutme'] . '</td>';
        echo '<td><img src="' . $entry['image'] . '" width="100" height="100"></td>'; //Display the image
        echo '<td><a href="edit_user.php?id=' . $i . '">Edit</a></td>';
        echo '</tr>';
    }
    ?>
</table>

<div>
    <?php
    // Display pagination links
    for ($page = 1; $page <= $totalPages; $page++) {
        if ($page == $currentPage) {
            echo "<span>$page</span> ";
        } else {
            echo "<a href=\"?page=$page\">$page</a> ";
        }
    }
    ?>

</div>

</body>
</html>



