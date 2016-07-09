var ShoppingListsContainer = React.createClass({
    getInitialState: function () {
        return {
            shopping_lists: this.props.shopping_lists
        }
    },
    getDefaultProps: function () {
        return {
            shopping_lists: []
        }
    },
    render: function () {
        return <div className="shopping_list_container">
            {
                this.state.shopping_lists.map(function (shopping_list) {
                    return <ShoppingList key={shopping_list.id} shopping_list={shopping_list}/>
                }.bind(this))
            }
        </div>;
    }
});
