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

    public function drawForm()
    {
        require 'Templates/Form.php';
    }

    public function addUser($fname, $lname, $email, $birthdate, $age, $aboutme, $imagePath)
    {
        $entry = [
            'fname' => $fname,
            'lname' => $lname,
            'email' => $email,
            'birthdate' => $birthdate,
            'age' => $age,
            'aboutme' => $aboutme,
            'image' => $imagePath,
        ];

        $this->data[] = $entry;
        $_SESSION['user_data'][] = $entry;

    }

    public function getUserData()
    {
        return $this->data;
    }

    public function drawUserTable()
    {
        $this->getUserData();
        $itemsPerPage = 3;
        $totalEntries = count($this->data);
        $totalPages = ceil($totalEntries / $itemsPerPage);
        $currentPage = isset($_GET['page']) ? $_GET['page'] : 1;

        $startIndex = ($currentPage - 1) * $itemsPerPage;
        $endIndex = min($startIndex + $itemsPerPage, $totalEntries);
        require 'Templates/User_Table.php';
    }

    public function processForm()
    {
        if (isset($_POST['submit']) && isset($_POST['fname']) && isset($_POST['email']) && isset($_POST['lname']) && isset($_POST['birthdate'])
            && isset($_POST['age']) && isset($_POST['aboutme']) && isset($_FILES['image'])) {
            $fname = $_POST['fname'];
            $lname = $_POST['lname'];
            $email = $_POST['email'];
            $birthdate = $_POST['birthdate'];
            $age = $_POST['age'];
            $aboutme = $_POST['aboutme'];

            if ($_FILES['image']['error'] === UPLOAD_ERR_OK) {
                $imageFileName = $_FILES['image']['name'];
                $imageTmpName = $_FILES['image']['tmp_name'];
                $imagePath = 'images/' . $imageFileName;

                $namePattern = '/^[A-Za-z\s]+$/';
                $emailPattern = '/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/';

                if (preg_match($namePattern, $fname) && preg_match($namePattern, $lname)) {
                    if (preg_match($emailPattern, $email)) {
                        if (is_numeric($age)) {
                            move_uploaded_file($imageTmpName, $imagePath);

                            $this->addUser($fname, $lname, $email, $birthdate, $age, $aboutme, $imagePath);
                        } else {
                            echo "Invalid age. Please enter a valid number for age.";
                        }
                    } else {
                        echo "Invalid email address. Please enter a valid email address.";
                    }
                } else {
                    echo "Invalid first name or last name. Only alphabetic characters and spaces are allowed.";
                }

            } else {
                echo "Error uploading image.";
            }
        }
    }

}

$userManager = new UserManagement();
$userManager->drawForm();
$userManager->processForm();
$userManager->drawUserTable();

?>