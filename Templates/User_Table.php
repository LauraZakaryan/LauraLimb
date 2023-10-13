<style>
    table, th, td {
        border: 1px solid black;
    }
</style>
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
        $entry = $this->data[$i];
        ?>
        <tr>
            <td><?= ($i + 1); ?></td>
            <td><?= $entry['fname']; ?></td>
            <td><?= $entry['lname']; ?></td>
            <td><?= $entry['birthdate']; ?></td>
            <td><?= $entry['age']; ?></td>
            <td><?= $entry['aboutme']; ?></td>
            <td><img src="<?= $entry['image']; ?>" width="100" height="100"></td>
            <td><a href="edit_user.php?id=<?= $i ?>">Edit</a></td>
        </tr>
    <?php } ?>

</table>

<?php
//Pagination
for ($page = 1; $page <= $totalPages; $page++) {
    $number = ($page == $currentPage) ? "<span>$page</span>" : "<a href=\"?page=$page\">$page</a> ";
    echo $number;
}
?>