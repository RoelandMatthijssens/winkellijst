var ShoppingListItem = React.createClass({

    getInitialState: function(){
        var item = this.props.item;
        return {
            name: item ? item.name : '',
            amount: this.props.amount
        }
    },
    getDefaultProps: function(){
        return {
            name: "",
            amount: 0
        }
    },
    render: function () {
        return <div>
            <Item name={this.state.name}/>
            <div>amount: {this.state.amount}</div>
            </div>;
    }
});
