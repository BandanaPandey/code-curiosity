$(document).on('page:load change', function(event){
  $('#monthly').on('click', '#one_time_pay', function(e) {
    
    e.preventDefault();
    // debugger
    $('#error_explanation').html('');

    var amount = $('#monthly #amount').val();
    $('#amount').val(amount)

    pay(amount);
  });

  $('#one_time').on('click', '#one_time_pay', function(e) {
    console.log('one_time');
    
    e.preventDefault();
    // debugger
    $('#error_explanation').html('');

    var amount = $('#one_time #amount').val();
    $('#amount').val(amount)
    pay(amount, 'one time pay');
  });
});

function stripe_checkout(type){
  var description = type ? type : 'monthly' 
  
  var handler = StripeCheckout.configure({
    key: key,
    locale: 'auto',
    name: 'Code-Curiosity',
    description: description,
    email: email,
    token: function(token) {
      $('input#stripeToken').val(token.id);
      if(type){
        $('#one_time #one_time_pay').parent().submit();
      }
      else{
        $('form').submit()
      }

    }
  });
  return handler;
}

function pay(amount, type=null){
  amount = amount.replace(/\$/g, '').replace(/\,/g, '')

    amount = parseFloat(amount);

    if (isNaN(amount)) {
      $('#error_explanation').html('<p>Please enter a valid amount in USD ($).</p>');
    }
    else if (amount < 5.00) {
      $('#error_explanation').html('<p>Donation amount must be at least $5.</p>');
    }
    else {
      debugger
      amount = amount * 100;// Needs to be an integer!
      handler = stripe_checkout(type);
      handler.open({
        amount: Math.round(amount)
      })
    }
    $(window).on('popstate', function() {
      handler.close();
    });
}

