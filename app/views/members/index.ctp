<!-- File: /app/views/members/index.ctp -->

<h1>Members</h1>
<table>
  <tr>
    <th>Id</th>
    <th>Username</th>
    <th>Password</th>
  </tr>

  <!-- Here is where we loop through our $posts array, printing out post info -->

  <?php foreach ($members as $member): ?>
  <tr>
    <td><?php echo $member['Member']['id']; ?></td>
    <td>
      <?php echo $this->Html->link($member['Member']['id'], 
array('controller' => 'members', 'action' => 'view', $member['Member']['id'])); ?>
    </td>
    <td><?php echo $member['Member']['username']; ?></td>
  </tr>
  <?php endforeach; ?>

</table>
