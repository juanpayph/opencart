<?php
class ControllerPaymentJuanPayStandard extends Controller {
	  function juanpay_hash($params) {
		$API_Key = $this->config->get('juanpay_standard_api_key');
		$md5HashData = $API_Key;
		$hashedvalue = '';
		foreach($params as $key => $value) {
		    if ($key<>'hash' && strlen($value) > 0) {
			$md5HashData .= $value;
		    }
		}
		if (strlen($API_Key) > 0) {
		    $hashedvalue .= strtoupper(md5($md5HashData));
		}
		return $hashedvalue; 
	   }
  
	protected function index() {
                $API_Key = $this->config->get('juanpay_standard_api_key');
                $this->log->write('API Key : '.$API_Key);
		$this->data['confirm_form_option'] = 'NONE'; 		
		$md5HashData = $API_Key;
                $this->language->load('payment/juanpay_standard');
		$md5HashData .= $this->data['confirm_form_option'];

		
		$this->data['text_testmode'] = $this->language->get('text_testmode');		
    	
		$this->data['button_confirm'] = $this->language->get('button_confirm');

		$this->data['testmode'] = $this->config->get('juanpay_standard_test');
		
		if (!$this->config->get('juanpay_standard_test')) {
    		$this->data['action'] = 'https://www.juanpay.ph/checkout';
  		} else {
			$this->data['action'] = 'https://sandbox.juanpay.ph/checkout';
			//$this->data['action'] = 'http://localhost:3000/checkout';

		}


		$this->load->model('checkout/order');

		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

		if ($order_info) {
			$this->data['business'] = $this->config->get('juanpay_standard_email');
   		        $md5HashData .= $this->data['business'];
			$this->data['products'] = array();
			$product_total = 0;
			foreach ($this->cart->getProducts() as $product) {
				$price = $this->currency->format($product['price'], $order_info['currency_code'], false, false);				
				$this->data['products'][] = array(
					'name'     => $product['name'],
					'price'    => $price,
					'quantity' => $product['quantity']
				);
                                $product_total = $product_total + ($product['quantity'] * $price);
      		                $md5HashData .= $product['name'];
      		                $md5HashData .= $price;
      		                $md5HashData .= $product['quantity'];

			}	
			$order_total = $this->currency->format($order_info['total'], $order_info['currency_code'], 1.00000, false);	
			if ($order_total<>$product_total) {
                            $this->data['other_fees_amt'] = $order_total - $product_total;	
                            $this->data['other_fees_name'] = "Other Fees";
			} else {
                            $this->data['other_fees_amt'] = 0;	
                            $this->data['other_fees_name'] = "";
			}
			$md5HashData .= $this->data['other_fees_amt'];
                        $md5HashData .= $this->data['other_fees_name'];

			$this->data['first_name'] = html_entity_decode($order_info['payment_firstname'], ENT_QUOTES, 'UTF-8');	
      		        $md5HashData .= $this->data['first_name'];
			$this->data['last_name'] = html_entity_decode($order_info['payment_lastname'], ENT_QUOTES, 'UTF-8');	
      		        $md5HashData .= $this->data['last_name'];
			$this->data['telephone'] = html_entity_decode($order_info['telephone'], ENT_QUOTES, 'UTF-8');	
      		        $md5HashData .= $this->data['telephone'];
			$this->data['email'] = $order_info['email'];
      		        $md5HashData .= $this->data['email'];
			$this->data['return'] = $this->url->link('checkout/success');
      		        $md5HashData .= $this->data['return'];
			$this->data['custom'] = $this->session->data['order_id'];
      		        $md5HashData .= $this->data['custom'];
                        $this->data['hash'] = strtoupper(md5($md5HashData));
		        $this->log->write('String to hash : ' . $md5HashData);
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/juanpay_standard.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/payment/juanpay_standard.tpl';
			} else {
				$this->template = 'default/template/payment/juanpay_standard.tpl';
			}
	
			$this->render();
		}
	}
	
	public function callback() {
		if (isset($this->request->post['custom'])) {
		   $order_id = $this->request->post['custom'];
		} else {
		   $order_id = 0;
		}		

                $hashedvalue = $this->juanpay_hash($this->request->post);

		if ($this->config->get('juanpay_standard_debug')) {
	           $this->log->write('post value : '.implode("|",$this->request->post));
	           $this->log->write('hash compute : '.$hashedvalue);
                   $this->log->write('hash post : '.$this->request->post['hash']);
                   $this->log->write('order number : '.$this->request->post['order_number']);
		}

                $order_id = $this->request->post['order_number'];

                if ($hashedvalue!=$this->request->post['hash']) {
                   if ($this->config->get('juanpay_standard_debug')) {
		      $this->log->write('invalid hash');
	           }               
                   die('invalid hash');
                }


		
		$this->load->model('checkout/order');
				
		$order_info = $this->model_checkout_order->getOrder($order_id);
		
		if ($order_info) {
			$request = '';
			foreach ($this->request->post as $key => $value) {
				$request .= '&' . $key . '=' . urlencode(html_entity_decode($value, ENT_QUOTES, 'UTF-8'));
			}
			
			if (!$this->config->get('juanpay_standard_test')) {
				$curl = curl_init('https://www.juanpay.ph/dpn/validate');
			} else {
				//$curl = curl_init('http://localhost:3000/dpn/validate');
				$curl = curl_init('https://sandbox.juanpay.ph/dpn/validate');
			}

			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, $request);
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_HEADER, false);
			curl_setopt($curl, CURLOPT_TIMEOUT, 30);
			curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
					
			$response = curl_exec($curl);
			
			if (!$response) {
				$this->log->write('PP_STANDARD :: CURL failed ' . curl_error($curl) . '(' . curl_errno($curl) . ')');
			}
					
			if ($this->config->get('juanpay_standard_debug')) {
				$this->log->write('PP_STANDARD :: DPN REQUEST: ' . $request);
				$this->log->write('PP_STANDARD :: DPN RESPONSE: ' . $response);
			}
						
			if (strcmp($response, 'VERIFIED') == 0  && isset($this->request->post['status'])) {
				$order_status_id = $this->config->get('config_order_status_id');
				switch($this->request->post['status']) {
					case 'Paid':
                                                if (strtolower($this->request->post['receiver_email']) == strtolower($this->config->get('juanpay_standard_email'))) {
							$order_status_id = $this->config->get('juanpay_standard_paid_status_id');
						} else {
							$this->log->write('PP_STANDARD :: RECEIVER EMAIL MISMATCH! ' . strtolower($this->request->post['receiver_email']));
						}
						
						break;
					case 'Overpaid':
                                                if (strtolower($this->request->post['receiver_email']) == strtolower($this->config->get('juanpay_standard_email'))) {
							$order_status_id = $this->config->get('juanpay_standard_overpaid_status_id');
						} else {
							$this->log->write('PP_STANDARD :: RECEIVER EMAIL MISMATCH! ' . strtolower($this->request->post['receiver_email']));
						}
						break;
					case 'Confirmed':
						$order_status_id = $this->config->get('juanpay_standard_confirmed_status_id');
						break;
					case 'Underpaid':
						$order_status_id = $this->config->get('juanpay_standard_underpaid_status_id');
						break;
					case 'Shipped':
						$order_status_id = $this->config->get('juanpay_standard_shipped_status_id');
						break;
				}
				
				if (!$order_info['order_status_id']) {
					$this->model_checkout_order->confirm($order_id, $order_status_id);
				} else {
					$this->model_checkout_order->update($order_id, $order_status_id);
				}
			} else {
				$this->model_checkout_order->confirm($order_id, $this->config->get('config_order_status_id'));
			}
			
			curl_close($curl);
		}	
	}
}
?>
