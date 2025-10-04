import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class SendMoneyScreen extends StatefulWidget {
  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String selectedMethod = 'Credit Card';
  bool isFavorite = false;
  bool showSuccess = false;

  final List<String> paymentMethods = ['Credit Card', 'Bank Transfer', 'PayPal'];

  void _sendMoney() {
    if (_formKey.currentState!.validate()) {
      setState(() => showSuccess = true);
      print('Transaction: ${_nameController.text}, \$${_amountController.text}, Method: $selectedMethod, Favorite: $isFavorite');

      Future.delayed(Duration(seconds: 2), () => setState(() => showSuccess = false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Money')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text('Send Money Easily!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Image.network(
                    'https://images.unsplash.com/photo-1567427018141-0584cfcbf1f9?auto=format&fit=crop&w=600&q=60',
                    height: 120,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Recipient Name'),
                    validator: (value) => value!.isEmpty ? 'Enter recipient name' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validator: (value) {
                      if (value == null || double.tryParse(value) == null || double.parse(value) <= 0) {
                        return 'Enter a valid amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedMethod,
                    items: paymentMethods
                        .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedMethod = value!),
                    decoration: InputDecoration(labelText: 'Payment Method'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mark as Favorite'),
                      Switch(value: isFavorite, onChanged: (value) => setState(() => isFavorite = value)),
                    ],
                  ),
                  SizedBox(height: 24),
                  CustomButton(label: 'Send Money', onPressed: _sendMoney),
                  SizedBox(height: 24),
                  AnimatedOpacity(
                    opacity: showSuccess ? 1.0 : 0.0,
                    duration: Duration(seconds: 1),
                    child: Text('Transaction Successful!', style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
