import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import "phoenix_html"
import { Socket } from 'phoenix';
import CommentsList from './CommentsList';
import CommentBox from './CommentBox';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = { comments: [] };
  }

  componentWillMount() {
    const socket = new Socket('/socket', {params: {auth_token: window.redditToken}})
    socket.connect()

    this.channel = socket.channel(`comments:${this.props.postId}`, {})
    this.channel.join()
      .receive('ok', resp => { this.setState({comments: resp.comments}); })
      .receive('error', resp => { console.log('Unable to join', resp) })

    this.channel.on(`comments:${this.props.postId}:new`, (data) => {
      const newComments = data.comments;
      this.setState({ comments: [...this.state.comments, ...newComments] });
    });
  }

  onCommentCreate(text) {
    this.channel.push('comment:add', { content: text });
  }

  render() {
    return (
      <div>
        <CommentBox onCommentCreate={this.onCommentCreate.bind(this)} />
        <CommentsList comments={this.state.comments} />
      </div>
    );
  }
}

window.renderCommentsApp = (target, postId) => {
  ReactDOM.render(<App postId={postId} />, document.getElementById(target));
};
