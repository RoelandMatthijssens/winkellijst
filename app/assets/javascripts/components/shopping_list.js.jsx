var ShoppingList = React.createClass({
    getInitialState: function () {
        return {
            shopping_list: this.props.shopping_list,
            shopping_list_items: this.props.shopping_list_items,
        }
    },
    componentDidMount: function () {
        var shopping_list_id = this.props.shopping_list.id;
        this.serverRequest = $.get("shopping_list/full_recursive/" + shopping_list_id + ".json", function (shopping_list) {
            console.log(shopping_list);
            this.setState({
                shopping_list: shopping_list,
                shopping_list_items: shopping_list.shopping_list_items
            });
        }.bind(this));
    },
    getDefaultProps: function () {
        return {
            shopping_list: null,
            shopping_list_items: []
        }
    },
    render: function () {
        return <div className="shopping_list">
            <div>shopping_list: {this.state.shopping_list.id}</div>
            <div>creator: {this.state.shopping_list.creator_id}</div>
            <div>household: {this.state.shopping_list.household_id}</div>
            <div>created: {this.state.shopping_list.created_at}</div>
            <div>updated: {this.state.shopping_list.updated_at}</div>
            <table>
                <thead>
                <th>Image</th>
                <th>Name</th>
                <th>Amount</th>
                <th>Actions</th>
                </thead>
                <tbody>
                {
                    this.state.shopping_list_items.map(function (shopping_list_item) {
                        return <ShoppingListItem key={shopping_list_item.id}
                                                 item={shopping_list_item.item}
                                                 amount={shopping_list_item.amount}/>
                    }.bind(this))
                }
                </tbody>
            </table>
        </div>;
    },

    //private

    getItemForShoppingListItem: function (shopping_list_item) {
        var itemId = shopping_list_item.item;
        $.each(this.props.items, function (index, item) {
            if (item.item_id == itemId) {
                return item;
            }
        });
    }

});
