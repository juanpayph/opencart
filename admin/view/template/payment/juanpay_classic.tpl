<?php echo $header; ?>
<div id="content">

    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>

    <?php if (isset($error['error_warning'])) { ?>
        <div class="warning"><?php echo $error['error_warning']; ?></div>
    <?php } ?>

    <div class="box">
        <div class="heading">
            <h1><img src="view/image/payment.png" alt=""/> <?php echo $heading_title; ?></h1>

            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
        <div class="content">

            <div id="htabs" class="htabs">
                <a href="#tab-api-details"><?php echo $tab_api_details; ?></a>
                <a href="#tab-general"><?php echo $tab_general; ?></a>
                <a href="#tab-status"><?php echo $tab_order_status; ?></a>
                <a href="#tab-customise"><?php echo $tab_customise; ?></a>
            </div>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

                <div id="tab-api-details">
                    <table class="form">
                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_username; ?></td>
                            <td><input type="text" name="juanpay_classic_username" value="<?php echo $juanpay_classic_username; ?>"/>
                                <?php if (isset($error['username'])) { ?>
                                    <span class="error"><?php echo $error['username']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_password; ?></td>
                            <td><input type="text" name="juanpay_classic_password" value="<?php echo $juanpay_classic_password; ?>"/>
                                <?php if (isset($error['password'])) { ?>
                                    <span class="error"><?php echo $error['password']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_signature; ?></td>
                            <td><input type="text" name="juanpay_classic_signature" value="<?php echo $juanpay_classic_signature; ?>"/>
                                <?php if (isset($error['signature'])) { ?>
                                <span class="error"><?php echo $error['signature']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $text_dpn; ?></td>
                            <td><?php echo $text_dpn_url; ?></td>
                        </tr>
                    </table>
                </div>

                <div id="tab-general">
                    <table class="form">
                        <tr>
                            <td><?php echo $entry_test; ?></td>
                            <td>
                                <?php if ($juanpay_classic_test) { ?>
                                    <input type="radio" name="juanpay_classic_test" value="1" checked="checked"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_test" value="0"/>
                                    <?php echo $text_no; ?>
                                <?php } else { ?>
                                    <input type="radio" name="juanpay_classic_test" value="1"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_test" value="0" checked="checked"/>
                                    <?php echo $text_no; ?>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_debug; ?></td>
                            <td>
                                <?php if ($juanpay_classic_debug) { ?>
                                    <input type="radio" name="juanpay_classic_debug" value="1" checked="checked"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_debug" value="0"/>
                                    <?php echo $text_no; ?>
                                <?php } else { ?>
                                    <input type="radio" name="juanpay_classic_debug" value="1"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_debug" value="0" checked="checked"/>
                                    <?php echo $text_no; ?>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_method; ?></td>
                            <td>
                                <select name="juanpay_classic_method">
                                    <option value="Sale" <?php  echo (($juanpay_classic_method == '' || $juanpay_classic_method == 'Sale') ? 'selected="selected"' : ''); ?>><?php echo $text_sale; ?></option>
                                    <option value="Authorization" <?php echo ($juanpay_classic_method == 'Authorization' ? 'selected="selected"' : ''); ?>><?php echo $text_authorization; ?></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_total; ?></td>
                            <td><input type="text" name="juanpay_classic_total" value="<?php echo $juanpay_classic_total; ?>"/></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_geo_zone; ?></td>
                            <td>
                                <select name="juanpay_classic_geo_zone_id">
                                    <option value="0"><?php echo $text_all_zones; ?></option>
                                    <?php foreach ($geo_zones as $geo_zone) { ?>
                                    <?php if ($geo_zone['geo_zone_id'] == $juanpay_classic_geo_zone_id) { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_currency; ?></td>
                            <td>
                                <select name="juanpay_classic_currency">
                                    <?php foreach($currency_codes as $code){ ?>
                                        <option <?php if($code == $juanpay_classic_currency){ echo 'selected'; } ?>><?php echo $code; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_status; ?></td>
                            <td>
                                <select name="juanpay_classic_status">
                                    <?php if ($juanpay_classic_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_sort_order; ?></td>
                            <td><input type="text" name="juanpay_classic_sort_order" value="<?php echo $juanpay_classic_sort_order; ?>" size="1"/></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_profile_cancellation ?></td>
                            <td>
                                <select name="juanpay_classic_profile_cancel_status">
                                    <?php if ($juanpay_classic_profile_cancel_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                    </table>

                </div>
                <div id="tab-status">
                    <table class="form">
                        <tr>
                            <td><?php echo $entry_canceled_reversal_status; ?></td>
                            <td>
                                <select name="juanpay_classic_canceled_reversal_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_canceled_reversal_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_completed_status; ?></td>
                            <td>
                                <select name="juanpay_classic_completed_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_completed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_denied_status; ?></td>
                            <td>
                                <select name="juanpay_classic_denied_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_denied_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_expired_status; ?></td>
                            <td>
                                <select name="juanpay_classic_expired_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_expired_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_failed_status; ?></td>
                            <td>
                                <select name="juanpay_classic_failed_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_failed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_pending_status; ?></td>
                            <td>
                                <select name="juanpay_classic_pending_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_pending_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_processed_status; ?></td>
                            <td>
                                <select name="juanpay_classic_processed_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_processed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_refunded_status; ?></td>
                            <td>
                                <select name="juanpay_classic_refunded_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_refunded_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_reversed_status; ?></td>
                            <td>
                                <select name="juanpay_classic_reversed_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_reversed_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_voided_status; ?></td>
                            <td>
                                <select name="juanpay_classic_voided_status_id">
                                    <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $juanpay_classic_voided_status_id) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                    <?php } ?>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="tab-customise">
                    <table class="form">
                        <tr>
                            <td><?php echo $entry_allow_notes; ?></td>
                            <td>
                                <?php if ($juanpay_classic_allow_note) { ?>
                                    <input type="radio" name="juanpay_classic_allow_note" value="1" checked="checked"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_allow_note" value="0"/>
                                    <?php echo $text_no; ?>
                                <?php } else { ?>
                                    <input type="radio" name="juanpay_classic_allow_note" value="1"/>
                                    <?php echo $text_yes; ?>
                                    <input type="radio" name="juanpay_classic_allow_note" value="0" checked="checked"/>
                                    <?php echo $text_no; ?>
                                <?php } ?>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_logo; ?></td>
                            <td valign="top">
                                <div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" />
                                    <input type="hidden" name="juanpay_classic_logo" value="<?php echo $juanpay_classic_logo; ?>" id="image" />
                                    <br />
                                    <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>
                                    &nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_border_colour; ?></td>
                            <td><input type="text" name="juanpay_classic_border_colour" value="<?php echo $juanpay_classic_border_colour; ?>" size="10"/></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_header_colour; ?></td>
                            <td><input type="text" name="juanpay_classic_header_colour" value="<?php echo $juanpay_classic_header_colour; ?>" size="10"/></td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_page_colour; ?></td>
                            <td><input type="text" name="juanpay_classic_page_colour" value="<?php echo $juanpay_classic_page_colour; ?>" size="10"/></td>
                        </tr>
                    </table>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript"><!--
    $('#htabs a').tabs();
//--></script>
<script type="text/javascript"><!--
    function image_upload(field, thumb) {
        $('#dialog').remove();

        $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

        $('#dialog').dialog({
            title: '<?php echo $text_image_manager; ?>',
            close: function (event, ui) {
                if ($('#' + field).attr('value')) {
                    $.ajax({
                        url: 'index.php?route=payment/juanpay_classic/imageLogo&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
                        dataType: 'text',
                        success: function(data) {
                            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
                        }
                    });
                }
            },
            bgiframe: false,
            width: 800,
            height: 400,
            resizable: false,
            modal: false
        });
    };
    //--></script>
<?php echo $footer; ?> 