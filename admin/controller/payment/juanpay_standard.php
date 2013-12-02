<?php
class ControllerPaymentJuanPayStandard extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/juanpay_standard');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('juanpay_standard', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');

		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_api_key'] = $this->language->get('entry_api_key');
		$this->data['entry_test'] = $this->language->get('entry_test');
		$this->data['entry_debug'] = $this->language->get('entry_debug');
		$this->data['entry_total'] = $this->language->get('entry_total');	

		$this->data['entry_confirmed_status'] = $this->language->get('entry_confirmed_status');
		$this->data['entry_underpaid_status'] = $this->language->get('entry_underpaid_status');
		$this->data['entry_paid_status'] = $this->language->get('entry_paid_status');
		$this->data['entry_overpaid_status'] = $this->language->get('entry_overpaid_status');
		$this->data['entry_shipped_status'] = $this->language->get('entry_shipped_status');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),      		
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/juanpay_standard', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = $this->url->link('payment/juanpay_standard', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['juanpay_standard_email'])) {
			$this->data['juanpay_standard_email'] = $this->request->post['juanpay_standard_email'];
		} else {
			$this->data['juanpay_standard_email'] = $this->config->get('juanpay_standard_email');
		}
		if (isset($this->request->post['juanpay_standard_api_key'])) {
			$this->data['juanpay_standard_api_key'] = $this->request->post['juanpay_standard_api_key'];
		} else {
			$this->data['juanpay_standard_api_key'] = $this->config->get('juanpay_standard_api_key');
		}

		if (isset($this->request->post['juanpay_standard_test'])) {
			$this->data['juanpay_standard_test'] = $this->request->post['juanpay_standard_test'];
		} else {
			$this->data['juanpay_standard_test'] = $this->config->get('juanpay_standard_test');
		}

		if (isset($this->request->post['juanpay_standard_debug'])) {
			$this->data['juanpay_standard_debug'] = $this->request->post['juanpay_standard_debug'];
		} else {
			$this->data['juanpay_standard_debug'] = $this->config->get('juanpay_standard_debug');
		}
		
		if (isset($this->request->post['juanpay_standard_total'])) {
			$this->data['juanpay_standard_total'] = $this->request->post['juanpay_standard_total'];
		} else {
			$this->data['juanpay_standard_total'] = $this->config->get('juanpay_standard_total'); 
		} 

		if (isset($this->request->post['juanpay_standard_confirmed_status_id'])) {
			$this->data['juanpay_standard_confirmed_status_id'] = $this->request->post['juanpay_standard_confirmed_status_id'];
		} else {
			$this->data['juanpay_standard_confirmed_status_id'] = $this->config->get('juanpay_standard_confirmed_status_id');
		}
		if (isset($this->request->post['juanpay_standard_underpaid_status_id'])) {
			$this->data['juanpay_standard_underpaid_status_id'] = $this->request->post['juanpay_standard_underpaid_status_id'];
		} else {
			$this->data['juanpay_standard_underpaid_status_id'] = $this->config->get('juanpay_standard_underpaid_status_id');
		}
		if (isset($this->request->post['juanpay_standard_paid_status_id'])) {
			$this->data['juanpay_standard_paid_status_id'] = $this->request->post['juanpay_standard_paid_status_id'];
		} else {
			$this->data['juanpay_standard_paid_status_id'] = $this->config->get('juanpay_standard_paid_status_id');
		}
		if (isset($this->request->post['juanpay_standard_overpaid_status_id'])) {
			$this->data['juanpay_standard_overpaid_status_id'] = $this->request->post['juanpay_standard_overpaid_status_id'];
		} else {
			$this->data['juanpay_standard_overpaid_status_id'] = $this->config->get('juanpay_standard_overpaid_status_id');
		}
		if (isset($this->request->post['juanpay_standard_shipped_status_id'])) {
			$this->data['juanpay_standard_shipped_status_id'] = $this->request->post['juanpay_standard_shipped_status_id'];
		} else {
			$this->data['juanpay_standard_shipped_status_id'] = $this->config->get('juanpay_standard_shipped_status_id');
		}




		$this->load->model('localisation/order_status');

		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['juanpay_standard_geo_zone_id'])) {
			$this->data['juanpay_standard_geo_zone_id'] = $this->request->post['juanpay_standard_geo_zone_id'];
		} else {
			$this->data['juanpay_standard_geo_zone_id'] = $this->config->get('juanpay_standard_geo_zone_id');
		}

		if (isset($this->request->post['juanpay_standard_status'])) {
			$this->data['juanpay_standard_status'] = $this->request->post['juanpay_standard_status'];
		} else {
			$this->data['juanpay_standard_status'] = $this->config->get('juanpay_standard_status');
		}
		
		if (isset($this->request->post['juanpay_standard_sort_order'])) {
			$this->data['juanpay_standard_sort_order'] = $this->request->post['juanpay_standard_sort_order'];
		} else {
			$this->data['juanpay_standard_sort_order'] = $this->config->get('juanpay_standard_sort_order');
		}

		$this->template = 'payment/juanpay_standard.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/juanpay_standard')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['juanpay_standard_email']) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>
