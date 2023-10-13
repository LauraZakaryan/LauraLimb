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
    <input type="submit" name="submit" value="Save Changes">
</form>