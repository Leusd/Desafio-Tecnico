({
    handleSubmit : function(cmp, event, helper) {
        event.preventDefault();       // stop the form from submitting
        const fields = event.getParam('fields');
        cmp.find('myRecordForm').submit(fields);
    }
})