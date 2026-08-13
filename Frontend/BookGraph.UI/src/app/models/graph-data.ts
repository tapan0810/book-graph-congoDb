export interface GraphData {
  nodes: GraphNode[];
  relationships: GraphRelationship[];
}

export interface GraphNode {
  id: number;
  labels: string[];
  properties: Record<string, unknown>;
}

export interface GraphRelationship {
  id: number;
  startNodeId: number;
  endNodeId: number;
  type: string;
}