// Display Line Item
function displayLineItem(lineItem, index){
  return `<tr>
            <th>`+index+`</th>
            <td><img src=`+lineItem.image+`></td>
            <td>`+lineItem.name+`</td>
            <td>`+lineItem.price+`</td>
            <td>`+lineItem.count+`</td>
          </tr>`
}

//Listing OrderList

var lineItems= JSON.parse(getCookie('lineItems'));
var orderLayout= '';
for(var variantKey in lineItems){
  var index = Object.keys(lineItems).indexOf(variantKey) + 1;
  orderLayout = orderLayout + displayLineItem(lineItems[variantKey], index);
}

$('.order .lineItems tbody').append(orderLayout);

//Purchase when click button

$('.order .purchase').click(function(){
  $.post( '/orders', {'orders': lineItems} ,function(){
    setCookie('lineItems','{ }',1)
  });
});
