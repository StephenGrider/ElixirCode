import { Socket } from 'phoenix';
let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

const createSocket = topicId => {
  let channel = socket.channel(`comments:${topicId}`, {});
  channel
    .join()
    .receive('ok', resp => {
      console.log(resp);
      renderComments(resp.comments);
    })
    .receive('error', resp => {
      console.log('Unable to join', resp);
    });

  channel.on(`comments:${topicId}:new`, renderComment);

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    channel.push('comment:add', { content: content });
  });
};

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector('.collection').innerHTML = renderedComments.join('');
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector('.collection').innerHTML += renderedComment;
}

function commentTemplate(comment) {
  let email = 'Anonymous';
  if (comment.user) {
    email = comment.user.email;
  }

  return `
    <li class="collection-item">
      ${comment.content}
      <div class="secondary-content">
        ${email}
      </div>
    </li>
  `;
}

window.createSocket = createSocket;
