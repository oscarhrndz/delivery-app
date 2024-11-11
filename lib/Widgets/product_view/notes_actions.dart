import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesAndActions extends StatefulWidget {
  final Function(int quantity) onAddToCart;
  final double productPrice;

  const NotesAndActions({
    Key? key,
    required this.onAddToCart,
    required this.productPrice,
  }) : super(key: key);

  @override
  _NotesAndActionsState createState() => _NotesAndActionsState();
}

class _NotesAndActionsState extends State<NotesAndActions> {
  int _quantity = 1;
  String _note = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price based on quantity and product price
    double totalPrice = _quantity * widget.productPrice;

    return Card(
      color: Color(0xFF292726),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        child: Column(
          children: [
            // Note section with line
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField for writing notes
                TextField(
                  controller: _noteController,
                  onChanged: (value) {
                    if (value.length <= 100) {
                      setState(() {
                        _note = value;
                      });
                    } else {
                      // If the input exceeds 100 characters, trim it
                      _noteController.text = _note;
                      _noteController.selection = TextSelection.fromPosition(TextPosition(offset: _note.length));
                    }
                  },
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    // Close the keyboard when "done" is pressed
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                    hintText: 'Add a note',
                    hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.7)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                  maxLines: null, // Allow multiple lines
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                // Quantity counter
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                      ),
                      Container(
                        width: 40,
                        child: Text(
                          '$_quantity',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 48),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onAddToCart(_quantity);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6AC092),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      minimumSize: Size(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add to Cart',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${totalPrice.toStringAsFixed(2)} EUR',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
