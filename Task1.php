<?php

class UserManagement
{
    private $data;

    public function __construct()
    {
        session_start();

        if (!isset($_SESSION['user_data'])) {
            $_SESSION['user_data'] = [];
        }

        $this->data = $_SESSION['user_data'];
    }

    public function addUser($fname, $lname, $birthdate, $age, $aboutme, $imagePath)
    {
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

            $this->data[] = $entry;
            $_SESSION['user_data'][] = $entry;
        } else {
            echo "Invalid first name or last name. Only alphabetic characters and spaces are allowed.";
        }
    }

    public function drawForm()
    {
        include('C:\wamp64\www\tasks\LauraLimb\Templates\Form.php');
    }

    public function getUserData()
    {
        return $this->data;
    }

    public function drawUserTable()
    {
        include('C:\wamp64\www\tasks\LauraLimb\Templates\User_Table.php');
    }

    public function processForm()
    {
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

                $this->addUser($fname, $lname, $birthdate, $age, $aboutme, $imagePath);

            } else {
                echo "Error uploading image.";
            }
        }
    }

}

$userManager = new UserManagement();
$userManager->drawForm();
$userEntries = $userManager->getUserData();
$userManager->drawUserTable($userEntries);
$userManager->processForm();

?>