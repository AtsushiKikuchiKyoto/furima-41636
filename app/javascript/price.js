function post (){
  const priceForm = document.getElementById("item-price");
  const taxForm = document.getElementById("add-tax-price");
  const profitForm = document.getElementById("profit");
  const taxRate = 0.1
  priceForm.addEventListener("input",()=>{
    let price = Number(priceForm.value);
    let taxPrice = Math.floor(price * taxRate);
    let profit = price - taxPrice;
    taxForm.innerHTML = taxPrice;
    profitForm.innerHTML = profit;
  });
};
 window.addEventListener('turbo:load', post);