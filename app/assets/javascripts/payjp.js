$(document).on('turbolinks:load', function() {
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_839895c840d4f91f7e75df7e');
  $(document).on("click", "#token_submit", function(e) {

    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);

    var card = {
        number: $("#card_number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val(),
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        alert('カード情報が正しくありません');
      }
      else {
        $("#number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        alert("登録が完了しました"); //確認用
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});

// document.addEventListener(
//   "DOMContentLoaded", e => {
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey('pk_test_839895c840d4f91f7e75df7e'); //ここに公開鍵を直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
//       btn.addEventListener("click", e => { //ボタンが押されたときに作動します
//         e.preventDefault(); //ボタンを一旦無効化します
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得します。
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) { //成功した場合
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); //取得したトークンを送信できる状態にします
//             document.inputForm.submit();
//             alert("登録が完了しました"); //確認用
//           } else {
//             alert("カード情報が正しくありません。"); //確認用
//           }
//         });
//       });
//     }
//   },
//   false
// );

// document.addEventListener(
//   "DOMContentLoaded", e => {
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e"); //ここに公開鍵を直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
//       btn.addEventListener("click", e => { //ボタンが押されたときに作動します
//         e.preventDefault(); //ボタンを一旦無効化します
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得します。
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) { //成功した場合
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); //取得したトークンを送信できる状態にします
//             document.inputForm.submit();
//             alert("登録が完了しました"); //確認用
//           } else {
//             alert("カード情報が正しくありません。"); //確認用
//           }
//         });
//       });
//     }
//   },
//   false
// );

// var form = $("#card__form");
//   Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e");
// //まずはテスト鍵をセットする↑
//   $("#submit_btn").on("click",function(e){
//     e.preventDefault();
//   //↑ここでrailsの処理を止めることでjsの処理を行う
//     var card = {
//       number: $("#card_number").val(),
//       cvc: $("#card_cvc").val(),
//       exp_month: $("#card_month").val(),
//       exp_year: $("#card_year").val()
//     };
//    //↑Pay.jpに登録するデータを準備する
//     Payjp.createToken(card,function(status,response){
//    //↑先ほどのcard情報がトークンという暗号化したものとして返ってくる
//       form.find("input[type=submit]").prop("disabled", true);
//       if(status == 200){//←うまくいった場合200になるので
//         $("#card_number").removeAttr("name");
//         $("#card_cvc").removeAttr("name");
//         $("#card_month").removeAttr("name");
//         $("#card_year").removeAttr("name");
//        //↑このremoveAttr("name")はデータを保持しないように消している
//         var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
//         form.append(payjphtml);
//         //↑これはdbにトークンを保存するのでjsで作ったトークンをセットしてる
//         document.inputForm.submit();
//        //↑そしてここでsubmit！！これでrailsのアクションにいく！もちろん上でトークンをセットしているのでparamsの中には{payjpToken="トークン"}という情報が入っている
//       }else{
//         alert("カード情報が正しくありません。");
//       }
//     });
//   });



// document.addEventListener("turbolinks:load", function() {
//   if (document.getElementById("token_submit") != null) {
//     Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e");
//     let btn = document.getElementById("token_submit");
//     btn.addEventListener("click", e => {
//       e.preventDefault();
//       let card = {
//         number: document.getElementById("card_number").value,
//         cvc: document.getElementById("cvc").value,
//         exp_month: document.getElementById("exp_month").value,
//         exp_year: document.getElementById("exp_year").value
//       }; 
//       Payjp.createToken(card, (status, response) => {
//         if (status === 200) {
//           $("#card_number").removeAttr("name");
//           $("#cvc").removeAttr("name");
//           $("#exp_month").removeAttr("name");
//           $("#exp_year").removeAttr("name");
//           $("#card_token").append(
//             $('<input type="hidden" name="payjp-token">').val(response.id)
//           );
//           document.inputForm.submit();
//           alert("登録が完了しました");
//         } else {
//           alert("カード情報が正しくありません。");
//         }
//       });
//     });
//   }
// },
// false
// );




// document.addEventListener(
//   "DOMContentLoaded", e =>{
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e"); //公開鍵直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得される
//       btn.addEventListener("click", e => { //ボタンが押されてイベント発火
//         e.preventDefault();
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200){
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name");//データを自サーバに保存しないようにname属性を削除
//             var token = response.id;
//             $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
//             $("#charge-form").get(0).submit();
//           }else{
//             alert("Error");
//           }
//         });
//       });
//     }
//   },
//   false
// );



// document.addEventListener(
//   "DOMContentLoaded", e =>{
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e"); //公開鍵直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得される
//       btn.addEventListener("click", e => { //ボタンが押されてイベント発火
//         e.preventDefault();
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; //入力されたデータを取得
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200){
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name");//データを自サーバに保存しないようにname属性を削除
//             var token = response.id;
//             $("#charge-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
//             $("#charge-form").get(0).submit();
//           }else{
//             alert("Error");
//           }
//         });
//       });
//     }
//   },
//   false
// );


// $(document).on('turbolinks:load',function(){
//   // PAY.JPの公開鍵をセットします。
//   Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e");

//   //formのsubmitを止めるために, クレジットカード登録のformを定義します。
//   var form = $(".form");

//   $("#charge-form").click(function() {
//     // submitが完了する前に、formを止めます。
//     form.find("input[type=submit]").prop("disabled", true);
//     // submitを止められたので、PAY.JPの登録に必要な処理をします。

//     // formで入力された、カード情報を取得します。
//     var card = {
//       number: $("#card_number").val(),
//       cvc: $("#cvc").val(),
//       exp_month: $("#exp_month").val(),
//       exp_year: $("#exp_year").val(),
//     };

//     // PAYJPに登録するためのトークン作成
//     Payjp.createToken(card, function(status, response) {
//       if (response.error){
//         // エラーがある場合処理しない。
//         form.find('.payment-errors').text(response.error.message);
//         form.find('button').prop('disabled', false);
//       }   
//       else {
//         // エラーなく問題なく進めた場合
//         // formで取得したカード情報を削除して、Appにカード情報を残さない。
//         $("#card_number").removeAttr("name");
//         $("#cvc").removeAttr("name");
//         $("#exp_month").removeAttr("name");
//         $("#exp_year").removeAttr("name");
//         var token = response.id;
//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         form.get(0).submit();
//       };
//     });
//   });
// });

// document.addEventListener("turbolinks:load", function() {
//   if (document.getElementById("token_submit") != null) {
//     Payjp.setPublicKey("pk_test_839895c840d4f91f7e75df7e");
//     let btn = document.getElementById("token_submit");
//     btn.addEventListener("click", e => {
//       e.preventDefault();
//       let card = {
//         number: document.getElementById("card_number").value,
//         cvc: document.getElementById("cvc").value,
//         exp_month: document.getElementById("exp_month").value,
//         exp_year: document.getElementById("exp_year").value
//       }; 
//       Payjp.createToken(card, (status, response) => {
//         if (status === 200) {
//           $("#card_number").removeAttr("name");
//           $("#cvc").removeAttr("name");
//           $("#exp_month").removeAttr("name");
//           $("#exp_year").removeAttr("name");
//           $("#card_token").append(
//             $('<input type="hidden" name="payjp-token">').val(response.id)
//           );
//           document.inputForm.submit();
//           alert("登録が完了しました");
//         } else {
//           alert("カード情報が正しくありません。");
//         }
//       });
//     });
//   }
// },
// false
// );















































