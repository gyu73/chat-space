$(function() {
  function buildHTML(message) {
    var html =
      `<div class= contents__right__center__message data-id= ${message.message_id}>
          <h3 class= contents__right__center__message__name>
            ${message.user_nickname}
          </h3>
          <h3 class= contents__right__center__message__date>
            ${message.created_at}
          </h3>
          <h3 class= contents__right__center__message__text>
            ${message.content}
          </h3>
          <div class= contents__right__center__message__image>
            <img src=${message.image} >
          </div>
        </div>`;
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
            <img src= ${message.image.url}>
          </div>
        </div>`;
    return html;
  }
 //メッセージの非同期通信のためのメソッド
  function SendAjax() {
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
  //自動更新のメソッド
  function getNewMessages() {
    var current_chat_group_id = $('.contents').data('chat-group-id');
    if(location.pathname == `/chat_groups/${current_chat_group_id}/messages`) {
      var LastMessageId = $(".contents__right__center__message:last-child").data("id");
      $.ajax( {
        type: 'GET',
        url: location.href,
        data: {
          LastMessageId: LastMessageId
        },
        dataType: 'json'
      })
      .done(function(data) {
        if(data.length != 0) {
          var html = '';
          $.each(data[1], function(index1, nickname) {
            $.each(data[0], function(index2, message) {
              html += updateHTML(message, nickname);
            });
          });
          $('.contents__right__center').append(html);
        }
      })
      .fail(function() {
        alert('メッセージを自動更新できませんでした。');
      });
    }
  }
  //自動更新のための記述
  var current_chat_group_id = $('.contents').data('chat-group-id');
  if(location.pathname == `/chat_groups/${current_chat_group_id}/messages`) {
    var timer = setInterval(getNewMessages, 5000);
  }
  else {
    clearInterval(timer);
  }
});
