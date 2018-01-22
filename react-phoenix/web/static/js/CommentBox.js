import React, { Component } from 'react';

class CommentBox extends Component {
  constructor(props) {
    super(props);

    this.state = { text: '' };
  }

  onSubmit(event) {
    event.preventDefault();

    this.props.onCommentCreate(this.state.text);
    this.setState({ text: '' });
  }

  render() {
    return (
      <form onSubmit={this.onSubmit.bind(this)}>
        <textarea
          value={this.state.text}
          onChange={e => this.setState({ text: e.target.value })}
        />
        <button>Submit</button>
      </form>
    );
  }
}

export default CommentBox;
