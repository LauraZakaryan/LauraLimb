<?php
class UserEditor
{
    private $userData;

    public function __construct()
    {
        session_start();
        if (!isset($_SESSION['user_data'])) {
            $_SESSION['user_data'] = [];
        }
        $this->userData = $_SESSION['user_data'];
    }

    public function drawEditForm($userId)
    {
        if (isset($this->userData[$userId])) {
            $user = $this->userData[$userId];

            include('C:\wamp64\www\tasks\LauraLimb\Templates\Edit_Form.php');

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



