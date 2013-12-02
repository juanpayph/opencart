<?php if ($testmode) { ?>
<div class="warning"><?php echo $text_testmode; ?></div>
<?php } ?>
<form action="<?php echo $action; ?>" method="post">
  <input type="hidden" name="confirm_form_option" value="<?php echo $confirm_form_option; ?>" />
  <input type="hidden" name="email" value="<?php echo $business; ?>" />
  <?php $i = 1; ?>
  <?php foreach ($products as $product) { ?>
  <input type="hidden" name="item_name_<?php echo $i; ?>" value="<?php echo $product['name']; ?>" />
  <input type="hidden" name="price_<?php echo $i; ?>" value="<?php echo $product['price']; ?>" />
  <input type="hidden" name="qty_<?php echo $i; ?>" value="<?php echo $product['quantity']; ?>" />
  <?php $i++; ?>
  <?php } ?>
  <input type="hidden" name="otherchargeamount" value="<?php echo $other_fees_amt; ?>" />
  <input type="hidden" name="otherchargename" value="<?php echo $other_fees_name; ?>" />
  <input type="hidden" name="buyer_first_name" value="<?php echo $first_name; ?>" />
  <input type="hidden" name="buyer_last_name" value="<?php echo $last_name; ?>" />
  <input type="hidden" name="buyer_cell_number" value="<?php echo $telephone; ?>" />
  <input type="hidden" name="buyer_email" value="<?php echo $email; ?>" />
  <input type="hidden" name="return_url" value="<?php echo $return; ?>" />
  <input type="hidden" name="order_number" value="<?php echo $custom; ?>" />
  <input type="hidden" name="hash" value="<?php echo $hash; ?>" />
  <div class="buttons">
    <div class="right">
      <input type="submit" value="<?php echo $button_confirm; ?>" class="button" />
    </div>
  </div>
</form>
