global class PicklistPopulation implements vlocity_ins.VlocityOpenInterface {
    public Boolean invokeMethod(String methodName, Map < String, Object > input, Map < String, Object > outMap, Map < String, Object > options) {
        if (methodName.equals('PopulatePicklist')) {
            PopulatePicklist(input, outMap, options);
        }
        return true;
    }
    // Get All Relationship Types for Account when the Omniscript is compiled.
    public void PopulatePicklist(Map < String, Object > input, Map < String, Object > outMap, Map < String, Object > options) {
        List < Map < String, String >> UIoptions = new List < Map < String, String >> ();
        for (CaseTeamRole rel: [Select Name, Id FROM CaseTeamRole]) {
            Map < String, String > tempMap = new Map < String, String > ();
            tempMap.put('name', rel.Name);

            // Language Independent
            tempMap.put('value', rel.Name);
            // Displayed in Picklist
            UIoptions.add(tempMap);
        }
        outMap.put('options', UIoptions);
    }
}