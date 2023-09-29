<?php
session_start();

if (!isset($_SESSION['user_data'])) {
    $_SESSION['user_data'] = [];
}
//Function to draw the edit form
function drawEditForm($user)
{
    echo '
    <h1>Registration</h1>
    
    <form action="" method="post" enctype="multipart/form-data">
    First name: <input type="text" name="fname" value="' . $user['fname'] . '"><br><br>
    Last name: <input type="text" name="lname" value="' . $user['lname'] . '"><br><br>
    Date of birth: <input type="date" id="birthdate" name="birthdate" value="' . $user['birthdate'] . '"><br><br>
    Age: <input type="number" id="age" name="age" min="1" max="1000" value="' . $user['age'] . '"><br><br>
    About me: <textarea name="aboutme" rows="5" cols="40">' . $user['aboutme'] . '</textarea><br><br>
    Image: <input type="file" name="image"><br><br>
            <img src="' . $user['image'] . '" width="100" height="100" alt="User Image"><br><br> 
    <input type="submit" name="submit" value="Save Changes"></form>';
}

if (isset($_GET['id']) && isset($_SESSION['user_data'][$_GET['id']])) {
    $userId = (int)$_GET['id'];

    if ($userId >= 0 && $userId < count($_SESSION['user_data'])) {
        //Get the user's data based on the ID
        $user = $_SESSION['user_data'][$userId];
        drawEditForm($user);


        if (isset($_POST['submit'])) {
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
                $user['image'] = $imagePath;
            }
            // Update user data
            $user['fname'] = $fname;
            $user['lname'] = $lname;
            $user['birthdate'] = $birthdate;
            $user['age'] = $age;
            $user['aboutme'] = $aboutme;

            // Update the user's data in the session array
            $_SESSION['user_data'][$userId] = $user;

            header("Location: Task1.php");
            exit;
        }
    } else {
        echo 'Invalid user ID.';
    }
} else {
    echo 'User ID not provided.';
}



