window.addEventListener("DOMContentLoaded", ()=> {

  if (location.pathname === "/items/new" || "/items/edit") {
    // console.log(location.pathname);
    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    priceInput.addEventListener("input", () => {
      const inputRegex = /^([1-9]\d*|0)$/;
      const inputValue = document.getElementById("item-price").value;

      if (inputRegex.test(inputValue)) {
        addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
        profitDom.innerHTML = Math.floor(inputValue * 0.9).toLocaleString();
      } 
    });
  }
});