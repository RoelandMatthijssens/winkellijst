var ShoppingListItem = React.createClass({

    getInitialState: function () {
        var item = this.props.item;
        return {
            name: item ? item.name : '',
            image: item ? item.image : '',
            amount: this.props.amount
        }
    },
    getDefaultProps: function () {
        return {
            name: "",
            image: "",
            amount: 0
        }
    },
    render: function () {
        return <tr className="shopping_list_item">
            <Item name="{this.state.name}"/>
            <td>{this.state.image}</td>
            <td>{this.state.name}</td>
            <td>{this.state.amount}</td>
            <td>checkmark</td>
        </tr>;
    }
});
