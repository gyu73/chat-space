$(function() {
  function buildHTML(chat_group) {

    var html =
      `<div class= contents__right__center__message data-id=${chat_group.message_id}>
          <h3 class= contents__right__center__message__name>
          ${chat_group.user_nickname}
          </h3>
          <h3 class= contents__right__center__message__date>
          ${chat_group.created_at}
          </h3>
          <h3 class= contents__right__center__message__text>
          ${chat_group.content}
          </h3>
          <div class= contents__right__center__message__image>
            <img src=${chat_group.image} >
          </div>
        </div>` ;
    return html;
  }

  function updateHTML(message, nickname) {

    var html =
      `<div class= contents__right__center__message data-id=${message.id}>
          <h3 class= contents__right__center__message__name>
          ${nickname}
          </h3>
          <h3 class= contents__right__center__message__date>
          ${message.created_at}
          </h3>
          <h3 class= contents__right__center__message__text>
          ${message.content}
          </h3>
          <div class= contents__right__center__message__image>
            <img src=${message.image.url} >
          </div>
        </div>` ;
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

  setInterval(getNewMessages,10000);

  function getNewMessages(){
    var LastMessageId = $(".contents__right__center__message:last-child").data("id");
    $.ajax({
      type: "GET",
      url: location.href,
      data: {
        LastMessageId: LastMessageId
      },
      dataType: "json"
    })
    .done(function(data){
      if(data.length != 0){
        var html = "";
        $.each(data[1], function(index1, nickname){
          $.each(data[0], function(index2, message){
            html += updateHTML(message, nickname);
          });
        });
        $('.contents__right__center').append(html);
      }
      else{
      }
    })
    .fail(function(){
    });
  }

});
