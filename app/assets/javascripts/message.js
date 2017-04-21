$(function() {
  function buildHTML(chat_group) {

    var html =
      '<div class= "contents__right__center__message">' +
      '<h3 class= "contents__right__center__message__name">' +
      chat_group.user_nickname +
      '</h3>' +
      '<h3 class= "contents__right__center__message__date">' +
      chat_group.created_at +
      '</h3>' +
      '<h3 class= "contents__right__center__message__text">' +
      chat_group.content +
      '</h3>' +
      '</div>' ;
    return html;
  }

  function SendAjax(){
    var text_data = new FormData($('#new_message').get(0));
    $.ajax({
      type: 'POST',
      url: location.href,
      data: text_data,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      $('.contents__right__center').append(html);
    })
    .fail(function() {
      alert('メッセージを入力してください。');
    });
  }

// 以下が送信ボタンが押された時に実行される
  $('.contents__right__bottom__form__send').on('click', function(e) {
    e.preventDefault();
    SendAjax();
  });
});
