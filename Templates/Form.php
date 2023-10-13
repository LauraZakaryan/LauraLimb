<?php echo
'<h1>Registration</h1>

<form action="" method="post" enctype="multipart/form-data">
    First name: <input type="text" name="fname"><br><br>
    Last name: <input type="text" name="lname"><br><br>
    Date of birth: <input type="date" id="birthdate" name="birthdate"><br><br>
    Age: <input type="number" id="age" name="age" min="1" max="1000"><br><br>
    About me: <textarea name="aboutme" rows="5" cols="40"></textarea><br><br>
    Image: <input type="file" name="image"><br><br>
    <input type="submit" name="submit" value="submit">
</form>';
