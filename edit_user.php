<?php
session_start();

class UserEditor
{
    private $userData;

    public function __construct()
    {
        if (!isset($_SESSION['user_data'])) {
            $_SESSION['user_data'] = [];
        }
        $this->userData = $_SESSION['user_data'];
    }

    public function drawEditForm($userId)
    {
        if (isset($this->userData[$userId])) {
            $user = $this->userData[$userId];

            ?>
            <h1>Registration</h1>

            <form action="" method="post" enctype="multipart/form-data">
                First name: <input type="text" name="fname" value=<?= $user['fname'] ?>><br><br>
                Last name: <input type="text" name="lname" value=<?= $user['lname'] ?>><br><br>
                Date of birth: <input type="date" id="birthdate" name="birthdate"
                                      value=<?= $user['birthdate'] ?>><br><br>
                Age: <input type="number" id="age" name="age" min="1" max="1000" value=<?=  $user['age'] ?>><br><br>
                About me: <textarea name="aboutme" rows="5" cols="40"><?= $user['aboutme'] ?></textarea><br><br>
                Image: <input type="file" name="image"><br><br>
                <img src="<?= $user['image'] ?>" width="100" height="100" alt="User Image"><br><br>
                <input type="submit" name="submit" value="Save Changes"></form>

            <?php
        } else {
            echo 'Invalid user ID.';
        }
    }

    public function updateUser($userId, $postData)
    {
        if (isset($this->userData[$userId])) {
            $user = $this->userData[$userId];

            $fname = $postData['fname'];
            $lname = $postData['lname'];
            $birthdate = $postData['birthdate'];
            $age = $postData['age'];
            $aboutme = $postData['aboutme'];

            if ($_FILES['image']['error'] === UPLOAD_ERR_OK) {
                $imageFileName = $_FILES['image']['name'];
                $imageTmpName = $_FILES['image']['tmp_name'];
                $imagePath = 'images/' . $imageFileName;
                move_uploaded_file($imageTmpName, $imagePath);
                $user['image'] = $imagePath;
            }

            $user['fname'] = $fname;
            $user['lname'] = $lname;
            $user['birthdate'] = $birthdate;
            $user['age'] = $age;
            $user['aboutme'] = $aboutme;

            $this->userData[$userId] = $user;

        } else {
            echo 'Invalid user ID.';
        }
    }

    public function getUserData()
    {
        return $this->userData;
    }

    public function processRequest()
    {
        if (isset($_GET['id'])) {
            $userId = (int)$_GET['id'];
            $this->drawEditForm($userId);

            if (isset($_POST['submit'])) {
                $this->updateUser($userId, $_POST);

                $_SESSION['user_data'] = $this->getUserData();

                header("Location: Task1.php");
                exit;
            }
        } else {
            echo 'User ID not provided.';
        }
    }
}

$editor = new UserEditor();
$editor->processRequest();



