<form action="" method="POST">
  x,y coordinates:<br>
  <textarea name="data" rows="5"></textarea><br> <br>
  <input type="submit" name="cluster" value="Cluster">
</form>

<?php
if(isset($_POST['cluster'])) {
  $arg = escapeshellarg($_POST['data']);
  $cmd = "Rscript cluster.R " . $arg . " &";
  pclose(popen(escapeshellcmd($cmd), 'r'));
}

