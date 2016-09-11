# TableViewInsets
Conform to this protocol and when the keyboard comes up your tableviews' insets will be adjusted and it won't be covered up by the keyboard!


#### 1. Conform

    class ExampleTableViewController: UITableViewController, TableViewInsetsAdjusting {


#### 2. Call setup (free function after you conform to TableViewInsetsAdjusting)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInsetAdjust()
    }


#### 3. Call takeDown (free function after you conform to TableViewInsetsAdjusting)

    deinit {
        takeDownInsetAdjust()
    }




Here is it all together:


    class ExampleTableViewController: UITableViewController, TableViewInsetsAdjusting {
    
      private var inputBar: TextInputBar = TextInputBar.viewFromNib()
      
      override func viewDidLoad() {
        super.viewDidLoad()
        setupInsetAdjust()
      }
      
      deinit {
        takeDownInsetAdjust()
      }
    
    }


Here's a blog post about it: [CheckoutMyCode](http://checkoutmycode.blogspot.com/2016/09/adjust-uitableview-for-keyboard.html)
