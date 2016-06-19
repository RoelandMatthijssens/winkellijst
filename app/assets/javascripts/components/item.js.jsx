var Item = React.createClass({
  render: function() {
    return (
      <div>
        <div>Name: {this.props.name}</div>
        <div>Image: {this.props.image}</div>
      </div>
    );
  }
});
