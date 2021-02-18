window.addEventListener("DOMContentLoaded", ()=> {

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");
  if (!priceInput) return false;  // これだけで出品と編集ページ以外で仕事させなくできる

  const calculate = () => {  // calculateは価格入力欄から手数料と利益を計算して表示させる関数
    const inputRegex = /^([1-9]\d*|0)$/;  // 0以外から始まる数字 or 0 を指定
    const inputValue = document.getElementById("item-price").value;
    if (inputRegex.test(inputValue)) {  // これ書かないと数値以外が入力された時に"NaN"とでる
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
      profitDom.innerHTML = Math.floor(inputValue * 0.9).toLocaleString();
    } 
  }

  calculate();  // 編集画面用
  priceInput.addEventListener("input", calculate);  // 出品画面用
});