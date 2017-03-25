var lineItems = {};

// Make Cart DropDown to close when click other element
$('body').click(function(evt) {
    if($(evt.target).parents(".cart").length==0 &&
       $(evt.target).parents(".cartBtn").length==0 &&
       $(evt.target).parents(".cartItem").length==0 &&
       !$(evt.target).hasClass('addToCart') &&
       !$(evt.target).hasClass('cartBtn') &&
       !$(evt.target).hasClass('cart')) {

      $('.cart').hide();
    }
});

function addItemToLineItems(variant) {
  var variant_id = variant.id;
  if(lineItems[variant_id] === undefined){
    lineItems[variant_id] = {
      name: variant.name,
      image: variant.image,
      price: variant.price,
      count: 1,
    }
  }
  else{
    lineItems[variant_id].count = lineItems[variant_id].count + 1;
  }
  return lineItems;
}

function createComponent(variant, variant_id) {
  return `<div class="cartItem">
    <span class="item">
      <span class="item-left">
          <img style="width:100px" src="` + variant.image + `" alt="" />
          <span class="item-info">
              <span>` + variant.name + `</span>
              <span>`+ variant.price +`</span>
              <span> X`+ variant.count +`</span>
          </span>
      </span>
      <span class="item-right">
          <button onclick='deleteItem()' data-variant-id=`+ variant_id +
            ` class="deleteBtn btn btn-xs btn-danger pull-right" href="#">x</button>
      </span>
    </span>
  </div>`
}

function deleteItem(){
  variant_id = $('.deleteBtn').attr('data-variant-id');
  delete lineItems[variant_id];
  renderLineItems(lineItems);
}

function renderLineItems(lineItems){
  $('div .cart').empty();
  var lineItemsLayout = '';
  for (var index in lineItems ){
    lineItemsLayout += createComponent(lineItems[index], index);
  }
  if(Object.keys(lineItems).length === 0) {
    $('div .cart').append(
      `<div class="cartItem"><h3> Wanna buy something ?</h3></div>`);
    $('.cartBtn .glyphicons').addClass('displayNone');
  }
  else {
    $('div .cart').append(lineItemsLayout);
    $('.cartBtn .glyphicons').removeClass('displayNone').attr(
      "data-count", Object.keys(lineItems).length);
  }
}
//check notice display
if(Object.keys(lineItems).length === 0) {
  $('.cartBtn .glyphicons').addClass('displayNone');
}
else {
  $('.cartBtn .glyphicons').removeClass('displayNone').attr(
    "data-count", Object.keys(lineItems).length);
}
// When click add to cart button append line items
$('.addToCart').click(function(event){
  var variant_id = $(this).attr('data-variant-id');
  var containClass =  '.variant_' + String(variant_id);
  var variant = {
    id: variant_id,
    name: $(containClass + ' .variantName').text(),
    image: $(containClass + ' img').attr('src'),
    price: $(containClass + ' .variantPrice').text()
  };
  var lineItems = addItemToLineItems(variant);
  renderLineItems(lineItems);
  $('.cartBtn .glyphicons').addClass('shake').addClass('shake-constant');
  setTimeout(function(){
    $('.cartBtn .glyphicons').removeClass('shake').removeClass('shake-constant');
  }, 200);
  $('div .cart').css('display','block');
});

// When click cart Btn render and display line items
$('.cartBtn').click(function(){
  $('div .cart').toggle('fast');
  renderLineItems(lineItems);
});
