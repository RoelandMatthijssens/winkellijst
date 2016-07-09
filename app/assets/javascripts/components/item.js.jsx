var Item = React.createClass({
    render: function () {
        return (
            <div className="item">
                <div>Image: {this.props.image}</div>
                <div>Name: {this.props.name}</div>
            </div>
        );
    }
});
