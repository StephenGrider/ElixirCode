import React, { Component } from 'react';

class CommentsList extends Component {
  renderComments() {
    return this.props.comments.map(comment =>
      <li key={comment.id} className="collection-item">{comment.content}</li>
    );
  }

  render() {
    return (
      <ul className="collection">
        {this.renderComments()}
      </ul>
    );
  }
};

export default CommentsList;
